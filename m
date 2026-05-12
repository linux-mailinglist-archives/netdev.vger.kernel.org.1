Return-Path: <netdev+bounces-287056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFC5D3/8AmpOzQEAu9opvQ
	(envelope-from <netdev+bounces-287056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:10:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F33951E4BF
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3715630459E4
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A224BCAAA;
	Tue, 12 May 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTy4Z3r1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nlZ2S0R7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16AD39A047
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580264; cv=none; b=GGuIMMUGnwCYgIDTNQkOT9Ezgg3hNemaNb1cs81mSWIXFFmHrxUsaC+nOyNSFUo+DxHwOgenknCKShblImVuy+TzzJQOHJq71Z1+aNyE2pgiUUR+Wpk2SzYcdZ7t1GPdMV39g74sQUOvO964yT/xMGKMC6oWMYMO4F5gZ9KMZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580264; c=relaxed/simple;
	bh=dH3eSM7f8VLLe5f6yZnNnzgC0LVj3cFbdyIYlGPbtGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdt+YFGaJT89tm1YLXdbCpVxQ3mkIavSZaPE8h2LxArjAl5ywcZB8TZXSM0ezUnBnQEhffBTQb5D38Xgf6TopSgMHfMAB7Dfk2nTXePclgnxlv6DJtEqdcY4MfAHDFM4qGDPCz1s3Pv+l0YMy1EgLAF/LKiaCkAFZZIswubDbrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HTy4Z3r1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nlZ2S0R7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778580261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlMuA9hwdFTP8K3r6A3IXWZ/9PMdiv8SdKkIEgo6+cU=;
	b=HTy4Z3r1cs0ih5AKTsNzQj9hAknzBxY15uK2Gz0wlI4dBA+uDv+P7scsCCmbtY2zhRFQWq
	/didr6y1pSI5OrkZsx3wib+WOLn4ADy3rVHt54rxlEL0OTq67N9Yk7ToRBPD5k8icJCpF2
	Gube0hxPuT4g36A4VVRaUhgaR8jgZO0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-611rGCazMI6LZP54BfRIqA-1; Tue, 12 May 2026 06:04:20 -0400
X-MC-Unique: 611rGCazMI6LZP54BfRIqA-1
X-Mimecast-MFC-AGG-ID: 611rGCazMI6LZP54BfRIqA_1778580259
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-bcea6a87383so193820266b.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 03:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778580259; x=1779185059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LlMuA9hwdFTP8K3r6A3IXWZ/9PMdiv8SdKkIEgo6+cU=;
        b=nlZ2S0R7PKBll4SChjJASv6TTgx6jAgE/Ot6Trltd8yxt4Xk9hGtzQSUtdtUtWVB4C
         +jqtPUmsW3Edg7uw0i4yUd/M4O3xR9wtn/v/bXHqSGXno2ZeAGr93nwjRhV72mfbOo6I
         0kUk23Th7mHHp35UaLNf8hI0mtWpIZvRkNnFV+JMG2oCUIPYpGT6zx/NfSQZBYpFa+lb
         Trek5EEqmWn2vYC3idP8zUKyCeBn9v18NCcHPcc2n5pvuNUphLR0qjnZkB+S6BjmpCfM
         S8xPXSw2XFla1XNJ5jB2mkB3QCEFc5Xj4xjrUqdJ/VbhKAJZKABJiO3Gh4Bc3s6OolU8
         Fykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778580259; x=1779185059;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlMuA9hwdFTP8K3r6A3IXWZ/9PMdiv8SdKkIEgo6+cU=;
        b=Zs/tLNQ9GQcWAyfsT8ZE8Yev8K2+b2bsESXiIoyH4rsBrH3A6FUO3ewc9zGqrCHgWl
         zMEIFuamvq+0Eb9edoA/EsnHo8KfLrehRrBJ7DCRDDhe43DVnawpZVdmi7rV9Zzdxmo/
         xZkzLDfpPbQn6ED1V95IsHsJwoRRB9++uUZh7+GF1N+dQkyMOjAEbTCWfQc/U5q2Qyo+
         BRhGp1JBgUSYAP9S7+DoIO2XC+FOtKKAlvL9L32xXaOU3odpn93KYEw/zeja+lMsT2eH
         zMCPcSmTVp4AHsHZ0YogJ7KSJmpXtwWDzfe4TRcx+kVvMylWK/eLUg6XkkgW0thpGUk0
         hVfA==
X-Forwarded-Encrypted: i=1; AFNElJ9F9UqvPgitb2VVhqQL//mPYYcLnwoJ8CYI50YVRYOpVgA68M8xUpa5RREh8UgCmvnZBHSmQKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPOOSNrxMAUWU5hdt1faOwwGNypy3vH/uz/6dehRhQ4Pc+S4yU
	FaNBsyDWTffFQYONLHFHfXtefPhfxQ6LjkBxnqMDs9Kv0vsStguWGmG5sz6Boh+r8jZ8BTAI20U
	MAbjB8zOdW/wTNrCzHLFvHghsdLOQGMqlP3FFxsHUXdfoBbr55C2LdpA2uw==
X-Gm-Gg: Acq92OFwnNiZpRDHVsfqK1aJIGZv0wdAn3qzbf0dEH7DtIsXhN7HHcNYzeAqXA9l01j
	JhhQE3AZOaPClNINZpRmPtWw9RnEwEHvXzYejQ9PqEPG5xFLgYxID12+b6YJ7sS854TonmXewNQ
	llgmUWen2GFVjhp1o/GwUkSeYuSuwv4mheQYsSBCuSit276npNXgbC8BoOw+Ob/MRN0UUlzslFb
	UlaIFZB+gBh/vfGEBw/H5diuMt7nE09Gh6uRD3R5X4/DUZ7TjMbaSr1yyuY9FQnNth2BGl4mZk6
	fajtxYkY6HiSo1jxTvX7vwLvSkVUlpGMjzMZkMhKDxsISIPkieU5gWTzx6bKKeB/9Px23B6dXOL
	Y42PptYMBU1eDp2QgeZC9ZL/N8r+WNuSzi2gL+/f7f2y8oq3ehva4jNM=
X-Received: by 2002:a17:906:7310:b0:bd0:df77:98bb with SMTP id a640c23a62f3a-bd0df77c9d6mr433617166b.9.1778580259231;
        Tue, 12 May 2026 03:04:19 -0700 (PDT)
X-Received: by 2002:a17:906:7310:b0:bd0:df77:98bb with SMTP id a640c23a62f3a-bd0df77c9d6mr433615266b.9.1778580258752;
        Tue, 12 May 2026 03:04:18 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac09c856asm656854166b.14.2026.05.12.03.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 03:04:18 -0700 (PDT)
Message-ID: <e6e4737e-e178-4d1a-a8d1-a45cea1db3a5@redhat.com>
Date: Tue, 12 May 2026 12:04:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/9] net: atlantic: implement AQC113 L2/L3/L4
 RX filter management filter management management
To: sukhdeeps@marvell.com, netdev@vger.kernel.org
Cc: irusskikh@marvell.com, epomozov@marvell.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, vadim.fedorenko@linux.dev, linux-kernel@vger.kernel.org
References: <20260506135706.2834-1-sukhdeeps@marvell.com>
 <20260508120156.3060-1-sukhdeeps@marvell.com>
 <20260508120156.3060-7-sukhdeeps@marvell.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260508120156.3060-7-sukhdeeps@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8F33951E4BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-287056-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Action: no action

On 5/8/26 2:01 PM, sukhdeeps@marvell.com wrote:
> @@ -530,6 +580,35 @@ static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
>  	return aq_hw_err_from_flags(self);
>  }
>  
> +static int hw_atl2_hw_mac_addr_set(struct aq_hw_s *self, const u8 *mac_addr)
> +{
> +	struct hw_atl2_priv *priv = self->priv;
> +	u32 location = priv->l2_filters_base_index;
> +	unsigned int h;
> +	unsigned int l;
> +	int err;

Minor nit: please respect the reverse christmas tree above (and elsewhere)

Side note: this patch is quite big, IMHO too much to be effectively
reviewed without relying entirely on automated tools, please try split
it into smaller chunks.

Also, when posting the next revision please on avoid send the patch in
reply to the previous iteration: it will foul both the tools and the
human behind them.

Finally please note that the patch subj contains repeated words, please
drop them.

/P


