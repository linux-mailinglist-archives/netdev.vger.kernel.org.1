Return-Path: <netdev+bounces-86465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4900589EE28
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4327A1C20FF6
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CAE154C04;
	Wed, 10 Apr 2024 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0B0UBgz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D5213D297
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740013; cv=none; b=JcmeA4QEkxVyTqR/wgSS/el7T/cpJcgP9J5Sae6f1yLkvrUINqZenPQs1a7lNxCwZ1MLN2sQxj/FVFM2aGI7iYHH3mZZ2fkR+4Vip/RohnoOERsqlfhiExohc1KY8Etipq1FcC7/oauyNbFDEhhLefcMmRUGH6lbxfCBIpJtvzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740013; c=relaxed/simple;
	bh=6mdsB5232IcHGyfFm7OtQmXgmaxA1ESa4+IqUtP52LM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hsv+Q42UKg2GbiaOS92B6CDNHmsHxaOhiMm0kRSmy2sgNC+EzQkOvKy1OkyTrXmKJCIDR0MDqKetBNn+y8N1KCBHzIpF4rz4hYt/diidS2bS/uA0WszxWane37kyxxna/TnD7qQKaOPAsTfJc4kFTPTCI4pA/UWjV4S6PJkYkBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0B0UBgz; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-6ecee5c08e6so6103866b3a.3
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 02:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712740012; x=1713344812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mdsB5232IcHGyfFm7OtQmXgmaxA1ESa4+IqUtP52LM=;
        b=O0B0UBgzoLHlhOpUf4jnmvK6vl1ZskeLTjZJbJrv8uXkDUFR2SoQTLW41L9KWCU2pl
         OxOJ20BeBNVFbI6p+cBJB+YxA111vGPbHIGv0Gr+hpfGCCxnt0XYgPvf3NxiOVsQtytu
         w4/Y9d9Mnfmi/EpdnUUnrCt1Fw5jiW+BuvJjNFzJ3lk7h2RRZkdVoCB7J75trPsOi+1E
         HPeTCiuCw4ixVQORAvvAlW6Ed8eJfd/K+1AWfvrUackIIRAtTBmJOxfV/nA4lqIykxCD
         UetmSOBU0rpioC0RC1KGYpJVBvhqVGHQ/TL/4ckLmuni++KC4XGF/luZnpsYM5acWqeF
         JT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712740012; x=1713344812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mdsB5232IcHGyfFm7OtQmXgmaxA1ESa4+IqUtP52LM=;
        b=mLeJNuOkqoP/mhVXTyekIl38g2GYN8jiqJVkxekUNVI5LNHSPE4uZDzqiwNLn9u7ML
         aVrJt/cuQftrJRxN0ITOX/2FYRfyMHttfe/6T+cUuMKm/zQDR5CuCB2bUhhHrVmazmPl
         8tXM0VHzZgkJJl27LACFyIO+D4PwQqZb9ESGf6jPIkqe4Gqvjb/vvdIkUij4tf6j24WH
         6WcYMgzUj0uksyUDaHXlObPTrdz7nGFhPYkTUiWgUmYV3SZyoBSv6jb5DWoMD3i5EI3X
         QWuLcdt/7iPyBpPNGzuD4nSsje9KrhusAQikvklznmsg6MijISoeQasQhF69MkkoIB0d
         kF3A==
X-Forwarded-Encrypted: i=1; AJvYcCWY7gasbEYMabesmuBd2yieI8AonjYrda/7F+y3sLRL2GxW/ZuT5Ep6PMte+6Fg7UehBKB8JtI8DEdmYQXBWJsfuhP/PmUs
X-Gm-Message-State: AOJu0Yyirk2LLq9LqpQYBSxLzc/xOlNhDtoBdeShiGso2yeOWEbB/izk
	CxC4D828QDmbxcNOgYvULEP19fi5t82wL4j+WQjUy+8omJ2Az1Bq
X-Google-Smtp-Source: AGHT+IHnSZ+/0Ise3zbEe3oSICChpaUQmiIIU9sqbFxX/0tUuJjUU3p7/ot23foqbf5fJHgQZ9ZRFQ==
X-Received: by 2002:a05:6a20:1582:b0:1a8:3607:6939 with SMTP id h2-20020a056a20158200b001a836076939mr2627641pzj.57.1712740011751;
        Wed, 10 Apr 2024 02:06:51 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id ff27-20020a056a002f5b00b006eac4d7b2e1sm9690977pfb.113.2024.04.10.02.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:06:50 -0700 (PDT)
From: xu <xu.xin.sc@gmail.com>
X-Google-Original-From: xu <xu.xin16@zte.com.cn>
To: gregkh@linuxfoundation.org
Cc: vladimir.oltean@nxp.com,
	LinoSanfilippo@gmx.de,
	andrew@lunn.ch,
	daniel.klauer@gin.de,
	davem@davemloft.net,
	f.fainelli@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	rafael.richter@gin.de,
	vivien.didelot@gmail.com,
	xu.xin16@zte.com.cn
Subject: Some questions Re: [PATCH net] net: dsa: fix panic when DSA master device unbinds on shutdown 
Date: Wed, 10 Apr 2024 09:06:44 +0000
Message-Id: <20240410090644.130032-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209120433.1942242-1-vladimir.oltean@nxp.com>
References: <20220209120433.1942242-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi! Excuse me, I'm wondering why this patch was not merged into the 5.15 stable branch.

Maybe I missed something.


Thanks.
xu xin

