Return-Path: <netdev+bounces-272738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEqyA6J5x2k+YAUAu9opvQ
	(envelope-from <netdev+bounces-272738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:48:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DD634D8AF
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9FF9300A391
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 06:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774542877F7;
	Sat, 28 Mar 2026 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="HI9ztUpy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F0C40DFD1
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 06:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774680465; cv=none; b=ljNjjHDvvMINe16n9BR6fEbdKT3nkaU+LF3CYKPU5JLaM25eV9D8jmNyhnLpfYpmPeDrJs7Hc39C/K+2KC9gmA877IgmJQ2uyEN3OUEt567s1DmVlI1ImrMvap0t2GL7Hhgx/Lk2y7ftjo1Auea/7HICxa/gS8490k4TS/WdBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774680465; c=relaxed/simple;
	bh=cveZp+Vy3Scii9Idd9Bdg1RVNpqTh3gkkpbJjk6j6Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyV8LtYO4Irn4prWplp+6QPwHdZLI5ckts1X9BboVvUruHG/bgfFiWw7wy5PYJTXJWShq+1xvoyAU5Q354XNc1X+4WepO4JQpp5rTGm2mFyX40J/PWqiAg/IFJ/9eB8thb1FrGwGFLnKJZ7QnRmvA25BkPKekPJ/iv3QZ947WOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HI9ztUpy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so26027435e9.2
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 23:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774680462; x=1775285262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xlZiBNibEuv2HGtFLqjsLg+70wU45AydbZfNpti4zn4=;
        b=HI9ztUpyeIvxsVZmB8GsW6dOGbHVM8wvDnUkfTqX16o4N1g34g+2Cqq3l/sLoHir3Z
         YiEtIYE7lI4IPrbL+BGEttku8hXDMpHMOX8H/HfuEK2kGU1WjPYOUEU6CvtKmvO6c8hE
         /2MLZeMImopxiVH9Xav6RPxQCXT2VIT4PTAa+zOxA/Li0Du6l7g6a4a74VSDZB3HbhEa
         BZ2NMj3xGKKnMADJv9+w3yENObzIt9ZeSQWObLKlxwonwbYuJA71K28wnhO1xZQR+jzE
         tA7Wp5ASSWkf6trgIZhdUeVVfZvYkxBT0k+PQtSEgvMs+hb1B47+85mlHwrZODj1VaG4
         kS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774680462; x=1775285262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlZiBNibEuv2HGtFLqjsLg+70wU45AydbZfNpti4zn4=;
        b=pIOF7T0F+trWoTpKlOSbl2MFZAMNNqF1w+mtU51PM4CjkYnN1Mzu5ZNqkYpOIUpuIg
         8J7vDloNdL16X1sLVRp0mxh8T6jcWgKi/lyOKPRCXjd0L+dcjVZWepDfLrAdWFXQ//4w
         5mVO9wp11UBwnClH3NhgQp10Qp4y7K8JEsJEKJgh+h7ypG26jSX6yH1IGwQ51PNtcsEf
         A/UJADkNC+S6JxdUbGw3afsKLPppjpGUtJuf60kjbj4SnrvQ/FYWeb7hLDudOgBjiZ+Z
         Gcb0bWVoal2F7PEtTqEvfQVMkdt25Uoy56/zXcWpwpdU0XotpyEQbiNd8fkrRBVBZVsQ
         VOew==
X-Forwarded-Encrypted: i=1; AJvYcCWspylGfTGdfReX6jLYoGfY7zGNSSFDWBJvfPQUbpDknGtzXg0q/iA1qJOfb7Xz91qbbxJrOUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf8oQgx0T6OKa3x2Mv80F4/7l11JbymZy5SUcpehKsU9EEF8Lb
	ftkD2SgPbWB5bNiBVRctHo5ufCDUvBrRB6z8YkvMv5ZmoqtNFvz8as9cd4qoMThAZFU=
X-Gm-Gg: ATEYQzybKjvMPwAtlcCqwfuNOib4uMQxWcly0APNoiHjYv38ek5Ty0/8i8CEwomv+Q2
	y2+lY/fQQ7IBjjcasDYig6qCaCVLFEPvBD3gXj6oL4tsgs3QaJo4FKuDn6oYQKc8MZNFAQWZDgw
	DfDR0VouVmLPufC+k2EMquGTzm5kGhZKVf2sVLFfu4Dp9si/tMW4v5GnQg53uKijVUsPoaCiceN
	10bBPKAvD8jaLmrTZF9F+huaMLtvk2ndXyvooEHHMVgioKiLieLnjBsfiotE3xBY7ICdsKgDISl
	kdshWNbML0i1FQQRRzr9IBrbcfQ9ndCHpJI9bIBIyoVaULE9RUrZGIOprkPHRmC7MGF+Pwu5oxv
	7TqjLb8inqpul+pwlAuoRZYM7BLfEXPF42xkRnXG2ukr/W8/+/h/PU1Cqj/TlLzGWpssyl6OIGB
	CFIINb+ELcEuOIPe5LF1DpQzvPaM7eMyS+3h1p7Lis2CGLmkvfx/hqmw==
X-Received: by 2002:a05:600c:19cf:b0:487:1108:48bc with SMTP id 5b1f17b1804b1-48727ec7695mr89821295e9.17.1774680462322;
        Fri, 27 Mar 2026 23:47:42 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245f87esm3137076f8f.22.2026.03.27.23.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:47:41 -0700 (PDT)
Message-ID: <d7fe9d67-e20c-426c-b3cf-7d3962a427a5@blackwall.org>
Date: Sat, 28 Mar 2026 08:47:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 04/14] net, ethtool: Disallow leased real
 rxqs to be resized
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260327121049.334562-1-daniel@iogearbox.net>
 <20260327121049.334562-5-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260327121049.334562-5-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272738-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei.uk:email,blackwall.org:dkim,blackwall.org:email,blackwall.org:mid,iogearbox.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54DD634D8AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/03/2026 14:10, Daniel Borkmann wrote:
> Similar to AF_XDP, do not allow queues in a physical netdev to be
> resized by ethtool -L when they are leased. Cover channel resize
> paths (both netlink and ioctl) to reject resizing when the queues
> would be affected.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>   net/ethtool/channels.c | 17 ++++++++++++-----
>   net/ethtool/ioctl.c    | 16 +++++++++++-----
>   2 files changed, 23 insertions(+), 10 deletions(-)
> 



Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


