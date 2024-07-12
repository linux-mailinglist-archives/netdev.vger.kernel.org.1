Return-Path: <netdev+bounces-111169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8FA93026E
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 01:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308491F21F24
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 23:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1170C130ACF;
	Fri, 12 Jul 2024 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UyLCa5+D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3712FB2F
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720827737; cv=none; b=iq7SJSv7GOpbgUDP4yWWadH9UuGpG1HP7qDg2f6lDZl7fUUcaNKcHXpzNv/aSuGvy8mC8Zhl4xwT85CPgsEE9ZllMVZ51SDK/p1gopFmqwqxnG/rHtqJcbZMSTEncbWBoRc9SOb3ZDJ0WFofjsvWWy67SN5nAWGaOYThNaFLm1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720827737; c=relaxed/simple;
	bh=fSkrhPafaY/UsSJ8429rDVH9DQNtuf0FQVHqiAYl7uM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=awiMW3OY/KhNyzhZWvnq6Gt+sGdWb4hjkyf+GoW2p0ifTIEbIJIgD/K7z9h8jVHqoro3ywtrha+bfyAHjPOGeBAh35PuXN3iehmTcIEAh/ea5+VgpDvs+0Fb0Pk7x1etN1ZOCeEV+6f82rzJN6WZnT1n8dLDnVb/LJYU0RpKg50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UyLCa5+D; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03a434e33cso4547666276.3
        for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 16:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720827734; x=1721432534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Emx9+Dx/QPnqRT3SzMKMZDYjlKNbiABmqgmJR0SHS0=;
        b=UyLCa5+DI1h6a2CmRXsrEO/qI5tTrEFGTjFBusdkT4Ab3VFM6LQHpEGFk27Rd9IZni
         EOP+krGWsZ4BSS8MK2YpX5pxQQ2uBqgDuX06HprqBU/w2Hnxi7uUBVuelkNSBjgCYGN2
         F7tco9YujuBjdbwDJoHDhFyuOMlGmu5FWX84R3jW5+9kymokHNtywUD9rh8MvBS0vQOP
         cuM7X8hCGsPggQk/fjvxjunN5xIBAaEmQumNbsDosLGWgiNBK4puC73KvVagackZm0Q1
         D19X/pVPpOx7T/RPpw7Xzze43YyWyptzX1pQtkLnXSMXyixO60hqt91QFew5mUUg0y54
         36gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720827734; x=1721432534;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Emx9+Dx/QPnqRT3SzMKMZDYjlKNbiABmqgmJR0SHS0=;
        b=KVTUm2r206MrrZu50QHgl4jv9mdgxcEKmOhpaxRpOXlEJJv0OZGF+gfyc+XIrtuJbg
         zbVemDBv1m8Vl/OImQniwvd4WOnpjnNK3+eowU0WYn9YusU1M0kLAK7mEwrHK4Gw4uiz
         yOhJsaKShZKbwL5Wtwtkiv1DSgq1QHlU7cGfW6gIJO2z2M2lDnPTCqiekhGEDfhAKrX+
         13IFraoxO8TaMFxyJm2Vrt9syxtht4TQMn+VOBfWk7f1SR3CE15AS6EAxncnIDPZUQZM
         3Nac5TNag/hjejGFuwekhr9W1cONXN7OO9tfrq8QynKNJDGYahe93drq48MksKTiBECp
         az6A==
X-Gm-Message-State: AOJu0YxS9oJ6VLBJQ/5e4m/3XF8VATc0lpEfaX6vSviQ/O9wBHbaBxHc
	nyUaY4QNg1DgPowVb28gjtXQdpQOPXpCheLExz3xukkvgTYmatX1VFXzzD3JDSp/lsxUDEm83xO
	ZzSbQeHGeQA==
X-Google-Smtp-Source: AGHT+IHWFARKNy821+rpJ2mSpwBHQoy6r9VL6c0Vv6f9NWnis8PojgJWfpZqYIWBzkqFDRgH2i3WRJN/r1IKqg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1b0e:b0:dff:1070:84b7 with SMTP
 id 3f1490d57ef6-e041b053db4mr26727276.5.1720827734510; Fri, 12 Jul 2024
 16:42:14 -0700 (PDT)
Date: Fri, 12 Jul 2024 23:42:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712234213.3178593-1-edumazet@google.com>
Subject: [PATCH net-next] MAINTAINERS: add 5 missing tcp-related files
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Following files are part of TCP stack:

- net/ipv4/inet_connection_sock.c
- net/ipv4/inet_hashtables.c
- net/ipv4/inet_timewait_sock.c
- net/ipv6/inet6_connection_sock.c
- net/ipv6/inet6_hashtables.c

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9540f9290f56bcbf00074cb5e108886d7d605d9f..fe5c08b6e253671786b7cb38df03ec1714fe08f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15767,8 +15767,13 @@ F:	include/linux/tcp.h
 F:	include/net/tcp.h
 F:	include/trace/events/tcp.h
 F:	include/uapi/linux/tcp.h
+F:	net/ipv4/inet_connection_sock.c
+F:	net/ipv4/inet_hashtables.c
+F:	net/ipv4/inet_timewait_sock.c
 F:	net/ipv4/syncookies.c
 F:	net/ipv4/tcp*.c
+F:	net/ipv6/inet6_connection_sock.c
+F:	net/ipv6/inet6_hashtables.c
 F:	net/ipv6/syncookies.c
 F:	net/ipv6/tcp*.c
 
-- 
2.45.2.993.g49e7a77208-goog


