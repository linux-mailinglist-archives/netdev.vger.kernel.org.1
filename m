Return-Path: <netdev+bounces-78525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E00875854
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 21:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4F4FB27F93
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 20:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557A8137C54;
	Thu,  7 Mar 2024 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R906bofL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D138A130E48
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843221; cv=none; b=cQQyGCFRe0bc6cmkjh80WeEUzrotqxQiukLu5BlfPMyvO73ibmepBvVAIBvUSJdr7BTzHrYrrKgETRplkYl/s4trjb2A3ly+IS1LYbGs9+Yl7gpHHwivKbZMatFOhlv+LCX9kYu0jGpRFOLyqo7FpwakOjON8xsHoqKUxox+vIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843221; c=relaxed/simple;
	bh=hCLrozahZx59NoBuAhc190VABzVi2N7RHPseclllnBM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uhmfvZLd18IMHJsef3IRe2S7q8dmyvFB3A8loGWBiDFy+3oxHqPYuLA87DdMKeYtIEOtDYd2k8wUd80F0iYUhz8SaV3RktmgSQOTa1tTq0xRvrAi0cY6aDEvBo+S2i47JNLwiT4OzG1p8fFTwXDroDb+a7si4bwnLHzBYaM6DqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R906bofL; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7882e94d408so104777485a.0
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 12:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709843218; x=1710448018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwQr4XJQXBVsGbJm0SwHUiqLtk1eG1gFa4/tLhAui/E=;
        b=R906bofL7GzU3EOBcjYW5AupG/M8ofyRWPeeQVTalMSkW7v/umk5K5++EJK0dmC+Ol
         Pq5BZseW6cgcy/i6yEGVk+k5kBy+HtwKJjMPo+FcUt06vOzMGbYpvWOhOXF8V6WGQeEg
         KHTpaOcA6B0CLmkQSMjX4GMbUsqkFTR5jPHbZ1VV6B34UNP7DuxveUQA8LOSYJQHPFpL
         2h0q2wHeNnmr+LXevhi+8h2ge4RY+ZSupaO+hvWi0wqfv5CMg5KgGMg/Z8Qdm9joJXmf
         Q8fJdaJ7D7G8JE0zs+3vxcW0Hnb8n4Q3q6k1jSrr3mjkk3/NEVMFJ4mvzbB1SnVpygIh
         b8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709843219; x=1710448019;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lwQr4XJQXBVsGbJm0SwHUiqLtk1eG1gFa4/tLhAui/E=;
        b=cFUfIXFmLollG3d93PbH+yg7WN9tU6NGMU/7fwyLFrpYkQ58gnigj+hngXrYQmfvAh
         nIfiCeSk9Io6RcHCqGEuhyRRk55kHKC7Sb/09oW9y1de8aC67G4B2zpUGpDWP2df+k31
         6r+QwmxImtgGwrcEpoCtlmIDANbWndOslrhWCbv9F7g4sccen6mKps6hYsYSmAvCPO3h
         gBLn32vGh3FZzi6RKUbALJa0mFeS9RN/aAehTnhrmUjroFNqN4dDKAP2THkk+/1tPhxt
         V5nym/1j42GjXk0ppLeX/EXSbkrk54tTaBWrIKDDOyaoP26xd67RRpDWZH5yIHfl3KRi
         PIlA==
X-Forwarded-Encrypted: i=1; AJvYcCX202YNAv7tC3EE7ooaEUhUbboCBR5uvpWdT/j3JUnVQOuJgfWr8bVAdpCDUphqrbo/ZJ0bsQTYDtEofc5Qt5sotVne3b8d
X-Gm-Message-State: AOJu0Yw59RCAr2Rr51/Ific/2c777A5wPfr6gIcBfMU9RUNhlaN0cVs3
	iD3I7jzaEZ2pWvFYPOpDNoWLLnDDFhIjlwxDmc67NuumUS6r82gdHH5wvy3F/Qc=
X-Google-Smtp-Source: AGHT+IH7SEiMAWvBoWfAl4aXojua31muZSo4uYgR7Zd+nvicu4sbRVoJXN/OpwIybqEss+P9qrDm9Q==
X-Received: by 2002:a0c:ab13:0:b0:690:a7b1:ee66 with SMTP id h19-20020a0cab13000000b00690a7b1ee66mr2080042qvb.65.1709843218548;
        Thu, 07 Mar 2024 12:26:58 -0800 (PST)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id lu4-20020a0562145a0400b006909887a53esm2020874qvb.130.2024.03.07.12.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 12:26:58 -0800 (PST)
Date: Thu, 07 Mar 2024 15:26:58 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <65ea23121a70e_10a0ad294a6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240307162943.2523817-1-edumazet@google.com>
References: <20240307162943.2523817-1-edumazet@google.com>
Subject: Re: [PATCH net-next] ipv6: raw: check sk->sk_rcvbuf earlier
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> There is no point cloning an skb and having to free the clone
> if the receive queue of the raw socket is full.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

