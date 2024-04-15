Return-Path: <netdev+bounces-88059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC9A8A57D5
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 18:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075171C2090D
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC5880C15;
	Mon, 15 Apr 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="A708rMeY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7136B
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198842; cv=none; b=meDWl8obe1cBAGwAYrl55YrNcsBwonXcBM978bd5eCU4ofezQ5gqn0nGHQSoaVlkXTe+0jQ84ds7AmJuWRvrbeslML17pVLHMDHhmhqc5+Xd42TW46HfIC7Hcu3wHiVvw5bfPLpeHcQwbmjrVUTeyR5aJUfPA3h6sp1a6AZ1itY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198842; c=relaxed/simple;
	bh=hTcP6EJd8PIWSXGBe/NqrDvXtTnOyEZA1WCyY5O/gbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XzZ7u3Vs0BXpbQoHHRp07Y+AFmoP7hJbPjIad+PJ00MNC39JB5bqDx409M226uMOQqablldYw7j7nJiXhEvGmdlcplghZzlYRpG3RylpSmCKZqRNgPEfw9AIPYRoGQZoC8ccv+fWbkAvlvXhpo7m71yLaGwz4ASCIpp786c+zDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=A708rMeY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e3f17c6491so28892535ad.2
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1713198840; x=1713803640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bfwg+Pm0fIqjL8q8xjQJj8wWrtb3lKmYftKLg5vyhkM=;
        b=A708rMeYKlHq8RDxEcm9FMTFjgpRzg2HPylRmkQg+IUsM0iZcbx19q5avMSoj4cjTp
         tRzA3EB4BlDJtboO79tfLOqADE9o4f8XjY3Csm1o9Uj20yo6bWqOohKhmL/U8ew9xuXU
         iQIv5o9evcUC4rYUgjpW6bwNkAZVZjvLTUAljnDbcjqEHEBagp4aB86U/ZbcbyTwTu7b
         wTcDBI4vVsm7zXOq+B4VJf45nuwpObW9hD7RU4njXTaSh6NxQxfwfGZVAMMe66TJm44q
         E/T0sj/UvKD1NqbIpmgiqO96AaPCGSapYp+VvzF7fNi1l+0lk5EsCk9Rf3we3x3gjoUG
         t8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198840; x=1713803640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bfwg+Pm0fIqjL8q8xjQJj8wWrtb3lKmYftKLg5vyhkM=;
        b=IcaDeix4hdyJ3Z94pH0+O1znWNNnB0bIJdrO7UIkfKVK/mEloKfGQyOLpOeiuDcpmF
         VntH82+rNEyxROXzwWXmbuBYGiV4B8op54h+RhJfEta+DSy8sZoid/+kSrPRWLYBURzu
         32hReyqQNYmKOyG0oiDGXpuCSI8HVnmN1+LIlnVdekPkx0iVBTOm1tVwFKUYSlnQ9K8q
         2Gp+VeY7bqw/6+tNTZzAzWin5ddpqOC2kBEwE+gh945F9ezTzX91rtqWRQsuOqCqMPXh
         jXUSw+YbS3H8mhrYXJOexhUdENaiU/2LwH6QkNyDliTAlInTJW1R0DXP0zbK++GjTk+o
         S/gA==
X-Gm-Message-State: AOJu0YzkIvSkMMwEMaHLK5n96c4BCpvo1xXyyQ0rnVsXAqeXipkKSgjl
	seKYvwsRV0Q7/FrPUKX2g9WwZxkDJFbgqalZhmTxGjU8po0LK09iUDETMH3h83If66JOP6m/pI7
	vFhQ=
X-Google-Smtp-Source: AGHT+IG6QJ+ww6v7QkLduLAf1j9Fh3O37F2Feu+Qyp4ukw3hAPq5izL4GOTD9nY8Brthm9cni0vWNg==
X-Received: by 2002:a17:902:bf48:b0:1e2:a2d7:9f5a with SMTP id u8-20020a170902bf4800b001e2a2d79f5amr9479340pls.65.1713198840008;
        Mon, 15 Apr 2024 09:34:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d2c100b001e3cee88212sm8136687plc.230.2024.04.15.09.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:33:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Parav Pandit <parav@nvidia.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] mnl: initialize generic netlink version
Date: Mon, 15 Apr 2024 09:33:47 -0700
Message-ID: <20240415163348.39425-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The version field in mnlu was being passed in but never set.
This meant that all places mnlu_gen_socket was used, the version would
be uninitialized data from malloc().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/mnl_utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/mnl_utils.c b/lib/mnl_utils.c
index af5aa4f9..6c8f527e 100644
--- a/lib/mnl_utils.c
+++ b/lib/mnl_utils.c
@@ -193,6 +193,8 @@ int mnlu_gen_socket_open(struct mnlu_gen_socket *nlg, const char *family_name,
 	if (!nlg->nl)
 		goto err_socket_open;
 
+	nlg->version = version;
+
 	err = family_get(nlg, family_name);
 	if (err)
 		goto err_socket;
-- 
2.43.0


