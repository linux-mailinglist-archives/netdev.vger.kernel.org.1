Return-Path: <netdev+bounces-164761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C611A2EF66
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1C21688B3
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBD7233138;
	Mon, 10 Feb 2025 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R8dN25Pd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE03231A3C
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739196672; cv=none; b=XL+cekZG+v4p6pdvgQm671/7DRmRH5Z/K4lOJ93QOEw05W75mYQrZ0Ctzy2KSJ6zU/e8sAiMXZ392ktBnbbrof4jipHdl4Hr/X6WL05cVEpkUKcnltSsU/gge+WA8sc0n0JMYsPRsMSYHkhYO7wlOxAEkLr0V915QPKj9SjWt78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739196672; c=relaxed/simple;
	bh=CrJKFWlnCDI2FZ4lKLW7Vf7WCdpVbHJIu4stf/aDmtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJMx4saAtLrBvdb4L88Bq0kVcrJ3NvDnpWBhkOTXpgryV4N4a/ZGtRMbK8HZ8zOkO8gPPBsfMdsZHr6Mdo0BVKa89W7lwfoELP8CUwsanbLzROxtfFJ6Kmqri2YUHC0lOIzVVi95/eU/bvh/4heg/t6kzOxKUGc82zOhv2nkICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R8dN25Pd; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38dd93a4e8eso1227688f8f.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 06:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739196667; x=1739801467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ykMeXqtDfbSzGAc/i1oX4lCWVOUKvKYl+ifVgwQb5zM=;
        b=R8dN25Pd0VZXdBjTVFCZN0Cg43aJot5CdPRZn/hri0vtbByS3QOGd9vWS6xDLz/UAx
         dwBz88xMHITP7DU9WC41kltPX/oIFj0TID7NJQ0sq+fXIxdiFrAYB3B/Q0Izcw6AhVWc
         ywiNebbGZmWYrOaoY943MIM6PzZzyRW+HXtnuvfmonnJCkvT/KIfSeNhpDL8FLGCJuTG
         b7WHsNLOobdNu4hKoyLrDp2jyEnV9bv3Dfag+2DpFaRaOyyo3QqFGAfqUAC5kBi0Yzf0
         RWV/x1iw5+SDR8M+oJhAv0jcqbE8tjiKlWflQB30TYe2+9Of90o0XWMnkHHBr0r00v8b
         4LCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739196667; x=1739801467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykMeXqtDfbSzGAc/i1oX4lCWVOUKvKYl+ifVgwQb5zM=;
        b=iNYfnQoXUwmv7nakl1S4+9y6M3YsUAsauTbzv6bVRFg9PNtVO63IYCxG9YW26hXYYY
         uDpltoDOGYX0FDLngjMJvs7azYSjfJzyHasj8hI7R7KDs4Joq3TBb5/6j+SIa8Aanvl7
         kLWiAZf+Pn1VIElcSLnsPw2IkPEZwncRJPEXJ9p6wwoPVM1uQ379RPKaC+wWsoNKzlBz
         +cGfJKW3JTlbcMfvVXPEdd6BbGWpeUQ7ZDk6C1gOsuYOPxNY8a+twrjEbvNKvAys76uE
         c3UJ7Zd9pcHmLv2v8lpsf5RS5C/vfFXiAXrSB5cOQNsZu72k3oxUHM7H2brJ9ab+kO1V
         FWYg==
X-Gm-Message-State: AOJu0YzkFymPQ7ev36AELU0CzyxnopAY/waFDQoM6o7+AC1S1OFbjyZY
	La+9wHrgwP5p4PNaJH9kJU0AdLc5ynL0ny0VfrbBzuc604XUU/P1BZ0MmoVPdVu3ptqqQTONcXe
	M
X-Gm-Gg: ASbGnct7+kerAd3OH8Z9cNVXH+5375G9UAkHhK8T4Wd0MI8itAxm09JenkAGnoAgnoZ
	2ww0vhZp4E0eIHAuY0PVk6ljmD2HfrM4pJYYQCRoesv7nDPXj3FtovL+xCIGwEi+IdwYqp9DtZE
	do4iNDUkBhQetVOCs9CMrNinDtW1h8z+RWo3mxwhLzgdZE13eBeaj+Ob/pk1vcToBa/iDYmoitN
	gTjfMx9zgoDBYDSYD7u1qfwhVlOJX42RK2YhTLmq5tLMVi2WwYe9D4NeJ4tQWGarjFHe7OAa/+C
	NCxvsRNGYK3GMOIXrA==
X-Google-Smtp-Source: AGHT+IGZqAlMr/NAFCu+gALkFjNVFDc7QOIx4CFPg/IpyGbv1PDU3DFlpMi5dGnZGK+JF6IpM1f01g==
X-Received: by 2002:a5d:59a9:0:b0:38d:dd43:8be5 with SMTP id ffacd0b85a97d-38ddd438e20mr3926817f8f.15.1739196667499;
        Mon, 10 Feb 2025 06:11:07 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7bca07294sm271656566b.68.2025.02.10.06.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 06:11:07 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: netdev@vger.kernel.org
Cc: mkoutny@suse.com,
	mkubecek@suse.cz
Subject: [PATCH] ss: Tone down cgroup path resolution
Date: Mon, 10 Feb 2025 15:11:03 +0100
Message-ID: <20250210141103.44270-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sockets and cgroups have different lifetimes (e.g. fd passing between
cgroups) so obtaining a cgroup id to a removed cgroup dir is not an
error. Furthermore, the message is printed for each such a socket.
Improve user experience by silencing these specific errors.
---
 lib/fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/fs.c b/lib/fs.c
index 622f28b3..6fe1d6db 100644
--- a/lib/fs.c
+++ b/lib/fs.c
@@ -223,7 +223,8 @@ char *get_cgroup2_path(__u64 id, bool full)
 
 	fd = open_by_handle_at(mnt_fd, fhp, 0);
 	if (fd < 0) {
-		fprintf(stderr, "Failed to open cgroup2 by ID\n");
+		if (errno != ESTALE)
+			fprintf(stderr, "Failed to open cgroup2 by ID\n");
 		goto out;
 	}
 
-- 
2.48.1


