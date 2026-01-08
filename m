Return-Path: <netdev+bounces-248114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE06D03B62
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D1AA322C86F
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5900B2D1F4E;
	Thu,  8 Jan 2026 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOT/uQK/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7Rzr0kV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3F92690D1
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884466; cv=none; b=R0cyetYRy+WmolI7iZUVIbphBa/tS80hkT2DET3rDQBzVhcvRrH/ZvexfeFMiXJTRJS7kOgd94GloKUvfrmGdxF4q//EWfT1M6zcKbJqyUPEwLp/o4dJL0N2kcAXoxRtrieQbxnholYj29Pm3X9lt+Hj/b3n8qnUhtQ9x1pgacE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884466; c=relaxed/simple;
	bh=x/KSeZmo4BpDEjmSmP/FoMnnJGbAD1EDOlqErMkqNac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGpqgY+JKmEWliCAglVe+SOLsswPYF7eCZvlQaJBn3wDLyiZ/MDbk0HxqVuSvbdQqJVGzqgQYdXCcNdAsQP8gnPUhadcxT9C4hZMREa4vZxLCWnMS1R0cL1hz1knrjKTEJJno6c/InThXr/YuYmExPjpBZ6c3qFhfyWSFt/qkN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOT/uQK/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7Rzr0kV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767884459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqGiJMM1pVcyveofpqbLm9RhIj56aLTI2bxMd5dfX0k=;
	b=iOT/uQK/kD/I4vGHKvFIFS5VoG6Y+7TYo8ULY0ztjivDfJDiMSDCT8VxU656PQL7preeR7
	Ky71ElZ8iMDKIw2bVl3SO+S1SWHIqc4UxuO+lipU3WYpu/vWcfIJlktzATsP/J8A0ygGiI
	kgTycH9uSzsDhbXRfHDcIi6fWB7pJ5I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-hDr5im0rNjKg-aNJiRx4Jw-1; Thu, 08 Jan 2026 10:00:58 -0500
X-MC-Unique: hDr5im0rNjKg-aNJiRx4Jw-1
X-Mimecast-MFC-AGG-ID: hDr5im0rNjKg-aNJiRx4Jw_1767884457
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43102ac1da8so2349671f8f.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 07:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767884457; x=1768489257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqGiJMM1pVcyveofpqbLm9RhIj56aLTI2bxMd5dfX0k=;
        b=S7Rzr0kV4Oc5LzZq6MJaoYlJiBa618ndKkT9Hh/WnSDRktJiq4CDzP2wIJWCJCvZeK
         D8F6JAuhTNUqrrPOJwbfi6+8l20KqBfOc7YlLx1dyrOYRqW0t/DjNB6xxOqHHc4QiG7T
         p1d0LjOit+/xG4qd4L0ub/bD/CBAEw8kBgaUPQbVGbEF+hFU2Fz7XFOKVH04iyDW+rZx
         C0O/nfxJnXpRlAPpavSiFWBk8fczKX+tKTqt9/LhsjNC1ayGTH/zVnbnfiWQufoE8f6M
         gzBmydIuxWxDKCfBs3L7chs8LdEohZh4mMrH0wd5C4+36+APGxntdeMIUQbaVHLAqQXZ
         Rqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767884457; x=1768489257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqGiJMM1pVcyveofpqbLm9RhIj56aLTI2bxMd5dfX0k=;
        b=kr3TnEozFhMHVAYBmNnG491LAiiuk3Qq4JIbcL0aCQRns+hdNopOpeieJobmz0SuYn
         XQ8r/LSvx2xdAdCDftzK6RRe2aSAKQWnjdddZ3l+q3L6XP2zekr8MgotD5RHYoRRdclL
         GqLldbk3YZTMAoc+UUa4Z8wA6qDJbJ6OLZaICsXCwcYS6N2qJuPkfs1Mk3QMD0x2x5Rr
         cFGBxIt/xPbm2ct8ZxsJ1kqfVXRPNNFhyS1oY3Uo/qoe3AgutQiJ9HJxYCZiurZ7bQTb
         aDVZBpCl3Ll+JYAhqQT2HkGA5yduITTJeDZmkMuedIfbony3dQC5bCyAAQBQVsdtHJ79
         LQQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAdakHy3G+0ccKqDCA3TawtFGBtABnfbm2NZ05e9PnWRsexxgruSogr3u4tLq+cDxFJg/5NHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+dY0k5hpYr4sMGgKhaDweoYns4KSZkLfAvyZz//U63mxDsHN
	hWUOJBnZE3RbW9UEqvdTirzXKwbA5E6Y1rdh7lsMnLO3Zxyo7Bd9XztmkuxTjsi1556FXjDTQcE
	taLGDxIm0/FHDhRTNvWLMs3FCpopW3e9elHhb0q8IUl0Ewe+SOJdf0cn+Yw==
X-Gm-Gg: AY/fxX5GVVtGXHgvEpBl4tPFQan30pHUbCgdFxQUWS9PVSzoG6EwLOZgALGE2XOri+j
	q2CtCIJOI/iTWl6Lq7y7kwUbNHmEiU9epG4pFvcywOotReg0QLQrRAVpjsRayN7m+Sj7GH08tXU
	70Snb5bf5i5RTsqdo/QWjQm8hIMEkC/IvG7HHnTCKmUuFgyDeaUHqqnr3G26szYLYtk18I53bwc
	rX4F1MuBdmXbQPmbbUZWNJulm4HyLyopc4UZZD4Mawvu6N7Lsyb2X5JMwxZ7lMLuqRoNoKTpY3D
	slF6n/DfeB6rBnhWDrKmQTsk3SATuk138rJd5cLDv1svVb7RmcpA2uKoSSUGgA1HNxJVOui4a1F
	ZyTpzM6W//+clZg==
X-Received: by 2002:a05:6000:603:b0:430:f72e:c998 with SMTP id ffacd0b85a97d-432c379f3d4mr7580416f8f.51.1767884456866;
        Thu, 08 Jan 2026 07:00:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEFTqZKQeu3SumB0qBMJBfqywsL0m05L0nnqVw7M8JGsK2WTMQCpTmAHt9TI/XwSLSTqMmww==
X-Received: by 2002:a05:6000:603:b0:430:f72e:c998 with SMTP id ffacd0b85a97d-432c379f3d4mr7580153f8f.51.1767884453818;
        Thu, 08 Jan 2026 07:00:53 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5fe83bsm17351709f8f.38.2026.01.08.07.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 07:00:53 -0800 (PST)
Message-ID: <1f31a9ac-01dd-4bb1-9a5a-ec67b381c5c0@redhat.com>
Date: Thu, 8 Jan 2026 16:00:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 05/16] quic: provide quic.h header files for
 kernel and userspace
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>,
 linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Paulo Alcantara <pc@manguebit.com>,
 Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1767621882.git.lucien.xin@gmail.com>
 <127ed26fc7689a580c52316a2a82d8f418228b23.1767621882.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <127ed26fc7689a580c52316a2a82d8f418228b23.1767621882.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/26 3:04 PM, Xin Long wrote:
> This commit adds quic.h to include/uapi/linux, providing the necessary
> definitions for the QUIC socket API. Exporting this header allows both
> user space applications and kernel subsystems to access QUIC-related
> control messages, socket options, and event/notification interfaces.
> 
> Since kernel_get/setsockopt() is no longer available to kernel consumers,
> a corresponding internal header, include/linux/quic.h, is added. 

Re-adding kernel_get/setsockopt() variants after removal, but just for a
single protocol is a bit ackward. The current series does not have any
user.

Do such helpers save a lot of duplicate code? Otherwise I would instead
expose quic_do_{get,set}sockopt().

/P


