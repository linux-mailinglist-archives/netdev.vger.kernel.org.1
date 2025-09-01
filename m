Return-Path: <netdev+bounces-218586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC6EB3D642
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 03:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCAD77A5292
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 01:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DC6145A05;
	Mon,  1 Sep 2025 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8lRBL+r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275384039;
	Mon,  1 Sep 2025 01:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756689492; cv=none; b=jg2zsCXoNnDfOAcVEsV0W8nWcfAffUVBmQIQV8Uc4ecjC7pCxQi6hhGzOcbnU8XgmQ7IgS3YD4DoxKUGR8KjGlom3oXz2rHCEZwBIg6H3E6d4y5XKK2iQBlYjsal64OxjaDRtMdOIbeXFncxDqQYal3/pE54qX1SevjibZIZ2WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756689492; c=relaxed/simple;
	bh=p6I//Oi2mAOM1e0o4MBI57Mdkv6UThxvsuFPthKg0po=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RcFRlEJNxaaGhlmS1xBiBKRrJC/YRB6TcztwQ3n/ThruwAKEt0Gp5MKWLo0x7RGMXAGfLHlEhmKDnXHqEjDAwqtvLIDnznlLfxScF5LXZBeRcDa2r4u2rW0Y508KjEDZOpCNuk+ynuuGpdiaMaUd/lWQOITuH469z/6IZgMhbow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8lRBL+r; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7fac0a7d2b1so363557085a.3;
        Sun, 31 Aug 2025 18:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756689490; x=1757294290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UF9AOPPJgtYkH9ridAfdzYjdYuWKr06VIGyxLDUlwDo=;
        b=F8lRBL+rae0M1IrcbteGKZ3Ea5PfnePtcHRpWKcuqBljad9lSyToAgmXuNVd1mt+bz
         dJt822gJKZ64I6bqlfboS9FBqHjlsbzVRuBVOv3EJ0uIAcMbdyxF8XtPNTeXbn/UwBFN
         Fa/J8HnPYiUYZOsrPpk4CYniEY8i+hy9pDMSdVdSrjZ5b0/Fpm6JzSLYgC7QnWXZ4eK0
         paHtvjMPMjj3/ER4TixXKOi7VSQGrJIiDpZbawOCMbshu+9U46PLfWk4FGAU6PZq41lX
         yfw2lTSIhLYzO/zHBwJ32EgR8/+F8aqmpnaqJPxKgSMJALRNpKkz1EaNTi0ZVFVsOGUF
         uMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756689490; x=1757294290;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UF9AOPPJgtYkH9ridAfdzYjdYuWKr06VIGyxLDUlwDo=;
        b=FAuxwMrwfGBrQIZUmAD0MIp3WwhK+3wZl0fgxQzvSmtSng8M/fI66/bJ/X3Ar7ViPh
         bu+Ns9c8F+OsKLJEovKKlZZA23x/jLnVwwtH3cxhMoGirPEkE3Mo45q4Lnwp5JJ1PBsc
         Wfrtd1sXyj+usty0NuP3QIy4mBcfdAYWTHGHjRjKXJNwjEN4CEk03U+T4K3GeYzGDGmv
         yZEIXPUVoJFFFs6lwB7F7qO+P//H2u8zWvS9O9iau2a+IYobnEkxpnN/WWxGNKVsH6GM
         qviU96vBnkiPqHkZGIMnpgr9woHGNkdK++kLKYbb5QGlNYYXDFY9vTGg8NA+QWOyw1X7
         LwBA==
X-Forwarded-Encrypted: i=1; AJvYcCULShsFCUPV9kByCubSt7kIjAUmWpFlHdb/pJbnijAhmsG1CTSYxvhql+hOJo+7cT3J5CeeL5Sd@vger.kernel.org, AJvYcCXlnxFh6D/YnqauQ1EE2F4cCPHWER4g3TPzzSQKKjfHf+pLpi+El9ze0hOnjI17zUF+sgFV70XBaTcgfeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/I6HCaltqbaEWAT0m/M6OgiN/MPAkZkHzsSRPeuQqez8Mdt4S
	pW3E1r/ZxXxCBfpr+IPkui++lSqpi+X7mJIOeYYCZkjmYO3ZkMAed4+j
X-Gm-Gg: ASbGnctVb2ANnUy9oLjXshEEhc9+3F8W3m0MRztOdmHbd+040z7XXFg/EwOsX++ODqz
	4zUQn28QgGTpSpHnxObO+JNFrQZ5GQ/YBzE8MSLg2+1/oo7TKl8qpNJ8ZS6nSz0WJy3sKIN38qz
	IBADvQAVZUtwy6U2c4j3wTMIyA5vRRkQxRO8pYAdm/XtfdA0pxoezxXdAyy5yeNk3fTzXorJ/Bs
	XsNjIA8ha6G3uRpgL6SGQ6iBmv8fIB8KJIplltqCG9Ll8EpujgzJWfP2SSlNwIGApB0nUt7/PaY
	I4nDG83yp//QCZSFoJMDJP3ZVsPWhQfZU8kGYh0prcMn65JgfgiY6o54hOWEgG6d4f5GQAFsYex
	3pBhtbfMVE6klP3Ll/K60OVKGF607YQeEsvluBt3iZJdwfZpU+rV8l2BJh93fwM+CqTqIPyrvjn
	VI7w==
X-Google-Smtp-Source: AGHT+IGbkc4IiKguM80Vt7bfd46KyPY+jYtexYF2JWesr9DyuOvO63VVFlTi4/1Lfqc5JWEMdA1r9A==
X-Received: by 2002:a05:620a:1909:b0:7fb:b855:a233 with SMTP id af79cd13be357-7ff2b0d9651mr665061185a.44.1756689489929;
        Sun, 31 Aug 2025 18:18:09 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70fb290189fsm31417606d6.70.2025.08.31.18.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 18:18:09 -0700 (PDT)
Date: Sun, 31 Aug 2025 21:18:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xin Zhao <jackzxcui1989@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 edumazet@google.com, 
 ferenc@fejes.dev
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Xin Zhao <jackzxcui1989@163.com>
Message-ID: <willemdebruijn.kernel.320d357b92e75@gmail.com>
In-Reply-To: <20250831100822.1238795-2-jackzxcui1989@163.com>
References: <20250831100822.1238795-1-jackzxcui1989@163.com>
 <20250831100822.1238795-2-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v10 1/2] net: af_packet: remove
 last_kactive_blk_num field
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xin Zhao wrote:
> kactive_blk_num (K) is incremented on block close. last_kactive_blk_num (L)
> is set to match K on block open and each timer. So the only time that they
> differ is if a block is closed in tpacket_rcv and no new block could be
> opened.
> So the origin check L==K in timer callback only skip the case 'no new block
> to open'. If we remove L==K check, it will make prb_curr_blk_in_use check
> earlier, which will not cause any side effect.
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

