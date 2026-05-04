Return-Path: <netdev+bounces-283726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMejDHVP+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:49:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D16574B99DA
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AFBC301AF43
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4ED3033F7;
	Mon,  4 May 2026 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="XFL9Is5g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C82E1D63F3
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880655; cv=none; b=FlIA0USJnjZVHgPdsuAYCyCwY8Hbcoe4DuO/M3q7cYX7pe0sRwoTbMD3ly+8lNQCfFHJTFasA20gNhuqZngmDvrKRWhResQGbpFIzStpnYHb1ayUQJSSYDMj+v9lfTqcArrbn7+02QKXV3z63B3qAo735wldHf54v/3tdkYdCc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880655; c=relaxed/simple;
	bh=WqTgDRyF7thxXL2tFuIlt/14bQOXqqiDNxfbMkQh+l0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5vC6UZFwtdO3yby5WCOHOmzxOsRY8xJiTa8Fsfqr8GrYnX8bZVPLvhH2wN3cCKxm5rE/avtL+4wIG+RGQauWQZFYIo7IdE4U5fEjwVKHPlwLZzqKjYIZtMY9XCPFDHx5iKbxXNJriOpwzkPJO7AYSep17bzxvAJlEQCk36Ckm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=XFL9Is5g; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-449e96a8a80so2041662f8f.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 00:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777880653; x=1778485453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BqVl4u47O1sLc62PW00yH8pyp8rHN1ZyUmrViFkDQUc=;
        b=XFL9Is5g1T1huGr0lGuFfsrGeJ43rtB7zVJRoKl9ccye2OYGNojfUWjor6vUUBtcRV
         /6l9h/9VXWOKiRb+SL5OKbwV3g9/De+7XsnULCXxwPA2FtiACr3jD5J8MRECk/lFX1EZ
         pYMt4A+6D6MXgb9p75q/lv4MnNnx5cy39KQFZeC5EIpycqoFHKQ66CVsi4FbQktCTngd
         hsxd2XZEF/6QxuO0pzRK2gnamBxHFL8OXdgdQSeeKvuq9CH43D/S7+vuER9//Jle2c09
         FPOd9jESw6CKA50O+7va40HqaTqPUrQqYY1BnFjaeo30tvGxBxfPf05EzU3wMdSWS+uJ
         cOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880653; x=1778485453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqVl4u47O1sLc62PW00yH8pyp8rHN1ZyUmrViFkDQUc=;
        b=ovk4rUG0jCmVKCcjiQS1uIVv1p+hH4m5wD6TFPA2LrfDfwAGyJA80TWi7BKlO/oBMA
         vjQ/3blG0d54mjaXmIop3mQPQG3YWojL2DbLPlCPibbUF7naEchZ237Pwlf/NykSp9qe
         IWDU1hgrQNcRZFvz3RoDx00IEHvBNNXp6nuf415fhvStfa6JZ+OyEp7fSBVMM39T6n34
         veRLJ4lEXPLQbdSeFf+QpYqArj94hgVSEugXNpHCWhybkk5u2a/q/gmevJmXNuU8fOEQ
         xl6iL+jMw3XwyXb1ipHkGZ1dBE1v0181hc8TR8R02oR29mzBwWzVUpt37WEhYSfN10ai
         6IkA==
X-Forwarded-Encrypted: i=1; AFNElJ8OuUlLp088LfWxw5YAF31p74/Wa8oRXPcsWW7PmlmgztHzyBL6FcouYHzKX5tE+h7Z46+IQUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlGTewe0ncXFhtbeiLwDVgN6146cOFLSla2s/lySlAREZkI+dU
	SQAzUlcJzzdvLkTUdP1qSoqgzuVhv2/HssY5UM/1peCGpfQOSOvoaYJVRFU575Cuqz8=
X-Gm-Gg: AeBDiet1SSwmVsQocBGc29uhu3y5jnOa5M7CfNPBGiSYwUiS2Z0RScKe25wPGPKpmiQ
	7Q9xM5q+q1tSqVtIOTYPZ8V2+WVmimHvvcaKtPnOhXtqRjfRLrbzpLTzboAtNMKdSwqCqVZijHF
	qwEfSGkK/0rrGcmb4R2BEhNNYK9h1W+cskMME2Bsxn0o2Bk1qQv8J04BhQB40aOrttlu+L12Rej
	j7xnEmvf21MAd4ZdTNQ7fXm0TC8rg7wFgr3MalvlKCN+XyNXL6ZrDE5izc2LpBTk5J16YzGNbs6
	s80icRUKQd9igA/8dC4jGgyVXssXGW3elw2AzZLbn17bGH3ZP7KYCS//OZyO/cNUbxoeai8tS2T
	Ik9xCHSDtmFMKdG17g3mPl/lGUTh/EnpL1nJv46bW1woEBqySxB1jMUcvBOtxgBOmAm31Vt2mUa
	RR6YuDc4CNhC1eHm1fFQgFR6CWUAoSwh2NLZLD0FVGPuddoLdK2uWUNYxxvDKEM6F6
X-Received: by 2002:a05:6000:2f83:b0:43f:e22e:e8da with SMTP id ffacd0b85a97d-44bb444393fmr14065131f8f.5.1777880652602;
        Mon, 04 May 2026 00:44:12 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a981ded99sm24332121f8f.18.2026.05.04.00.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:44:12 -0700 (PDT)
Message-ID: <fbbc57a7-76c7-434d-af40-4f0e8c314aad@blackwall.org>
Date: Mon, 4 May 2026 10:44:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/6] selftests: net: Add tests for
 neigh_forward_grat option
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 andrew+netdev@lunn.ch, shuah@kernel.org, ast@fiberby.net,
 liuhangbin@gmail.com, daniel@iogearbox.net, aroulin@nvidia.com,
 fmaurer@redhat.com, sdf.kernel@gmail.com, sd@queasysnail.net,
 kees@kernel.org, nickgarlis@gmail.com, amorenoz@redhat.com,
 alasdair@mcwilliam.dev, johannes.wiesboeck@aisec.fraunhofer.de,
 petrm@nvidia.com, linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260503073532.2138165-1-danieller@nvidia.com>
 <20260503073532.2138165-7-danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260503073532.2138165-7-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D16574B99DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,fiberby.net,iogearbox.net,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283726-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On 03/05/2026 10:35, Danielle Ratson wrote:
> Add tests to validate the neigh_forward_grat bridge option for selective
> forwarding of gratuitous neighbor announcements.
> 
> The tests verify per-port and per-VLAN control of gratuitous neighbor
> announcement forwarding for both IPv4 (gratuitous ARP) and IPv6
> (unsolicited NA):
> - When neigh_suppress is enabled with neigh_forward_grat off (default),
>    gratuitous announcements are suppressed
> - When neigh_forward_grat is enabled, gratuitous announcements are
>    forwarded while regular neighbor discovery remains suppressed
> 
> For IPv4, use arping to send gratuitous ARP packets. For IPv6, use
> mausezahn to craft unsolicited Neighbor Advertisement packets.
> 
> For the per-port tests, the IPv4 test exercises the ip link interface,
> while the IPv6 test exercises the bridge link interface.
> The per-VLAN tests use the bridge interface throughout, as per-VLAN
> attributes are only accessible via 'bridge vlan'.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>   .../net/test_bridge_neigh_suppress.sh         | 298 +++++++++++++++++-
>   1 file changed, 296 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


