Return-Path: <netdev+bounces-256829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMbGGJi9g2mqtwMAu9opvQ
	(envelope-from <netdev+bounces-256829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 22:43:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F10ECD2F
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 22:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78BF03000A1F
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 21:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EFC395DB1;
	Wed,  4 Feb 2026 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYPKNrHs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D9B395DA7
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241429; cv=none; b=I7dc9IxRKyuMIZjMBuevK8ZwkmWChdgDc7aa+DCh92bk1QBR6e0obZaMFUc8JNlCAYfDm3HR5jCrf4csrQv+CkGIVTwEKKA9Fgn0Bc3PUzipRpxKVM7ZGDFpIafzLlsikeo1mhOzcFr1kDWYywdSdWUCHZDMK2j1dGmVBmj3A3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241429; c=relaxed/simple;
	bh=uSjSJKl78hq5Lia6xEiKVGn/CTPRc1DWNzhv5Hr+Rp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPhCi/7LrDduP+IKYEtzsjFeXNiBhBJp/kTXonYR/6TyflOehj1l7HTgaYRneYAt4tNqpiUEAqbRKc55oezGNEOTze46lIAv6MCPhyGwr0r+mE82M4jRCJXRp/M8OQxxP2sP4/cl5TKI620mHUj7abP6RszFEKIPxeGAxmT7rNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYPKNrHs; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c70ce93afaso22236185a.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 13:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770241428; x=1770846228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXsIhyRwNN/Bse960XszdsU+YtMe68nKzM0mD5g1vRY=;
        b=bYPKNrHsV8znY7lqPqQvUv14MkFB5e7QtFWiH8Obk5YnF9vPzafoFdxX38ItBOPtgd
         sSwsRma+jiWhA2DkK2IMFTb2gpqjvwlYKgMy3wG4cjTQeRu6ZqAQCELs7tJ2MOhwVoLf
         DdnOR2ANOU1HFcIuWvuiDlPQ7xYgBM553S0lFfUGUCljVkUdvcH6Clm2quCnz8wKF/QW
         MZblvLahM/bY0UhKXHA+W8smfJ41ljiJnccuUMQR0dVp9uha+PTEQRejqlEy49TdJPNV
         yaHc6T7QEixpsGU13r+9Vt2tGUvpwFOosnwtcKlI8QwdD3LiSIl2d/MpMIiORUxQekDV
         OUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770241428; x=1770846228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXsIhyRwNN/Bse960XszdsU+YtMe68nKzM0mD5g1vRY=;
        b=NCoo+T9cjCgNdTkuautza7AxhEEfyG4WacONKrcWn1Mj7fHkl9Xf5MAOSly3dc4QjC
         YwRga3/SgCXfvcAGzWQ2FBuTDZuURmpXmbQ0Dys7eGhizhvFgIHTiUXibfjBe/OATzrR
         HU2t3ltbwmAGiKzvnoOEH9/tijOryybGhcxuDGqaGVxCyvFVqjoIybRNoPcy4k0DwYxz
         Y/Vdf0ovnTravcr4w9lUise/FuB/bv91FqY1jOYdBq5PJYd/ItP5hOsP/10Ub+X4PAUG
         vmtIUTL8iGsBxlYavKkVWN/6qhS7qaGrgD9FWUT4Lxo/qiJZX7wWFZpOGb9n8ITgH7LB
         AEtw==
X-Gm-Message-State: AOJu0YwOyzQAcIwuNCJs/x6Y4yducUnIuzTFf7D9adj4hX7a1Uts5p00
	SYWHDJGFPlTb4GbHxtGMTljRbzOe5GbTmz1A0deRHGyafDvEOt93Ygh5
X-Gm-Gg: AZuq6aJBsRSDIOBHYawz7w4ApokAF73sIbM6iQ45Fwp1ouDqnH5rYt0S05Z7N/SwJ10
	HcmEPDjy4BpukJmqxs/T5jLVcgV1bCo4CNq9nV1tnm/+awjT+tJJealP1ZRbjL8FfukP6twN5fv
	EDzfDEmKjU33Bguvvb3xw1C3gMV8o46fxykChOo68OxspmiZvEg/6qlyWYce1i81X90HaSWX1OF
	yg6t7Uj1m/YsK9310H+aqXj/s9zdmk/ReR7M7Ljf4vWpF4hGVxzh2M1EArNIijpoob/3zWMuXJn
	boOQV0iIj3gdPdNsVUSU0i3sgo0cW53MngzuBZhYQm3w83NlryN9t9gGzsfTIb/gLr5TXlZ2KqW
	7AuU5Jb/cEYc+C4Y2FFOqPWzjV2lW07bNih8XwcpK6j8EOtNDlfjhhFxfHLePewkyjvX17IDQW3
	n+CEhoUUO3emlOSizdiDAq2rY1ZjufiYPvs6nnRlYL7mMuA1J7umnRPAMR/iGpyrEJNQ==
X-Received: by 2002:a05:620a:4cc:b0:8ca:305b:7481 with SMTP id af79cd13be357-8ca305b7504mr455744485a.61.1770241428298;
        Wed, 04 Feb 2026 13:43:48 -0800 (PST)
Received: from ?IPV6:2600:4040:93b8:5f00:52dd:c164:4581:b7eb? ([2600:4040:93b8:5f00:52dd:c164:4581:b7eb])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd2df44sm269881185a.30.2026.02.04.13.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 13:43:47 -0800 (PST)
Message-ID: <f3560398-d6fa-4f05-9496-f0e59a5c0fd2@gmail.com>
Date: Wed, 4 Feb 2026 16:43:46 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/9] psp: support rekeying psp protected tcp
 connections
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
 <willemdebruijn.kernel.37bf21c78aadd@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <willemdebruijn.kernel.37bf21c78aadd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256829-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,lunn.ch];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2F10ECD2F
X-Rspamd-Action: no action



On 2/4/26 3:45 PM, Willem de Bruijn wrote:
> Daniel Zahka wrote:
>> In the case of tx rekeying, as soon as we install the new tx key, we
>> have no use for the previous one, and it can be disposed of
>> immediately.
> So this defines a rekey event as an instant in time. An alternative
> choice is to rekey at a specific seqno.
>
> The difference matters only for retransmits.
>
> Not sure there is a strong reason for either. But probably good to
> state the choice explicitly.

I suppose if we think about a rekey as occurring at a seqno we could do 
away with the deferred key deletion, and instead just wait for data sent 
before that seqno to be ack'd before deleting the key. I would say if 
nothing else that would be a significant improvement over what I have 
right now.


