Return-Path: <netdev+bounces-237503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C98C4CA93
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C52634ECCF
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59BD2F1FF1;
	Tue, 11 Nov 2025 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8AZ31i7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d91VcPOb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2C12ED15D
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853407; cv=none; b=PL/0jdsr5kZq4L2DubEMriQMfVIf/zx6bIvvXzjxMbaBrQwr2mOw6FRiW7gYIxX/B/C36JYyiS3JcTeZpmUP2YbMDM9FfbQ0hVHlFQ976QVrjsIlVGAKSK0BEYKvtnn1tPtVBptOcpae+dhXwWOMjfO8sGfk09j32GZg1q0PvO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853407; c=relaxed/simple;
	bh=wexyvat/0SYqqKjEF/5VtMpaGazcWYImhu/WttpvyBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIKaldlrHSMhtatthP8yilWIL1o7yOh34SNDXUeazw+pp94v42EKfdUCRdu98nzBK5gdRcMlrVXigqmor4gE70cIhd/NHd8TfpK63JUh6dqsiyApaQDDpABU1Orr2MFpDeKsJ8SJdw8cYEqYfr9903IHbRVXRiF4H+BCdyafLqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8AZ31i7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d91VcPOb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762853405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+yful8XuD1rOWAT4s6PVlCJAW6mP+A9zgtwVM3K1L1M=;
	b=a8AZ31i758vCEaHprux9ZeGrVdFFTvn+OTU4dKl03Bj7+JFsrVLgPslTsft0bnSecrL/56
	IkQq3hP7T4qRhgcvUVv4XipjGH9cVoedXEkM8xiW+g6qfJwa2HxL0T8boZuVGN2wlWagGZ
	7mWguGdiopPpTLzVTmS2SIMdOHELHnI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-xp_Cv9aEORqUPLgbmYwGPw-1; Tue, 11 Nov 2025 04:30:03 -0500
X-MC-Unique: xp_Cv9aEORqUPLgbmYwGPw-1
X-Mimecast-MFC-AGG-ID: xp_Cv9aEORqUPLgbmYwGPw_1762853402
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b352355a1so260690f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762853402; x=1763458202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yful8XuD1rOWAT4s6PVlCJAW6mP+A9zgtwVM3K1L1M=;
        b=d91VcPObXpRHQNM8tQxVPult8PQc8HfTSP7WYvQ0i0MNr66xtfgTYAdOa7/sakgOcF
         /4BkyrZ02vdxdM81ORL0igEWuea5xNefCsung/rJQv7ognM0Vdtdf3PfWsDhT8jJrEfD
         tVK4c+tUh2txxyyBevI1VH8uYgQZt4AOGfLO3ZpxrTmvIYY8KZttnQdWiSyFH/Wq+Is5
         LFt+hvdFDC0rByjybqekGrkyL35RKca7P0RxrNePp2M+HoN6hQSvwbXIIPXo2qj1e1Vx
         ak430DsojIFVe8RPiTyqXDHC38jCJZ5zP+4TdhupHAIrNeTYJtY0KNlDhC2N4dRl6hYR
         gKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853402; x=1763458202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yful8XuD1rOWAT4s6PVlCJAW6mP+A9zgtwVM3K1L1M=;
        b=ouCnTSLtGx7AOB2a39ZFCsb+WD1Kdq8H2Xxbr6jN/zCkI07bHmOEovrHEeO2r9Ozsi
         Fc0/icFuxPXyTLJxe7t75QzXcVGtGkaQdk6zhOZHP+VYLxik6w5y76ngq585OJlOVKh/
         KpI2QbX0SVTTgHYumIBfHotzNq1Ie46VCA4RnQEgqQh9id5/ZhYRXnlqRsQGVSEIv2aq
         9n6WvJQ+oHhPOLOQ6Oe26zjWuw2C9mUIh7My/3KNL/tPqcdBPs+uGCYIE2xLfWDlWuw0
         v+6n0Jrf8/RNfwKoJZwnBugBXHZ9NHX6XMVtnusDWEiff23diqGAYdqoyMo6354sb2CZ
         NOvw==
X-Forwarded-Encrypted: i=1; AJvYcCV2KmK2NHJvTJIbGL5gp0merBcicu38QKgZ25ajox3oNxPtRZxwwGE7HPCueuHg+HshsFS1Egs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Jrzc4i+NkeDpJR/LPITNIk01RGtFOs7Ian+R/q1dkh7Y1H1D
	1fxqjeQmk6cCq3DmHck0FIW6U7Obodf1Et4HHbQXuzvzejrFuHKuxddiBUOLS4D4hDku8PKQPK8
	Y/mH7XhPZ47p9Tw7ATGhlrB9beiZKsw6kHuH/FpZN4YSJSisqxSim+FmsFA==
X-Gm-Gg: ASbGncvTjOfoVpSoElZivEFT9i3/lyK7z3ZjnQuHtR3f+0xa0iEwXRWkcAfOwm/VFET
	TcQXm3/Mw+XUpo1ilUCm0dniq3HqcO3G/4x7gN6xmFrDTmdobYJztUasVdvIan8HoEBsngfr+ma
	uJkXCWF3rY7jasm1HbOUbdkacYfHdp60sCTLh2DViKTMTQ5dIUQEmyAMfKMyPl7XMFhHoocFRH1
	vKGnU5uhn1qoEBF4lW+/xCCQQuyZIHo5ZF/LtSEHTO4Dh6hLdGqh0X5orsqZeSG/yyVJ9rKFSzb
	NWBV4WuEqE5DaqTwcVjK1pxBAoDFJX/1MMnS6F1+JTok+kC5b+7JU/v3Xv5bEv3sFvKMFR3Nixn
	IPg==
X-Received: by 2002:a05:6000:4312:b0:42b:3455:e4a1 with SMTP id ffacd0b85a97d-42b432c93d0mr2041925f8f.15.1762853402422;
        Tue, 11 Nov 2025 01:30:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYsOpckTu4T5+pAfy7v94Qj5GGQZdQQIzQt5CZrzblwz3VQAr9XYobfFM+3VkqMQLnNjiYOA==
X-Received: by 2002:a05:6000:4312:b0:42b:3455:e4a1 with SMTP id ffacd0b85a97d-42b432c93d0mr2041903f8f.15.1762853401941;
        Tue, 11 Nov 2025 01:30:01 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2b08a91esm21407249f8f.2.2025.11.11.01.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 01:30:01 -0800 (PST)
Message-ID: <a84ce374-8693-4f53-876b-973c9ddff031@redhat.com>
Date: Tue, 11 Nov 2025 10:29:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] xsk: add indirect call for xsk_destruct_skb
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20251031103328.95468-1-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251031103328.95468-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/25 11:33 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Since Eric proposed an idea about adding indirect call wrappers for
> UDP and managed to see a huge improvement[1], the same situation can
> also be applied in xsk scenario.
> 
> This patch adds an indirect call for xsk and helps current copy mode
> improve the performance by around 1% stably which was observed with
> IXGBE at 10Gb/sec loaded. If the throughput grows, the positive effect
> will be magnified. I applied this patch on top of batch xmit series[2],
> and was able to see <5% improvement from our internal application
> which is a little bit unstable though.
> 
> Use INDIRECT wrappers to keep xsk_destruct_skb static as it used to
> be when the mitigation config is off.
> 
> Be aware of the freeing path that can be very hot since the frequency
> can reach around 2,000,000 times per second with the xdpsock test.
> 
> [1]: https://lore.kernel.org/netdev/20251006193103.2684156-2-edumazet@google.com/
> [2]: https://lore.kernel.org/all/20251021131209.41491-1-kerneljasonxing@gmail.com/
> 
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

My take here is that this should not impact too negatively the
maintenance cost, and I agree that virtio_net is a legit/significant
use-case.

Cheers,

Paolo


