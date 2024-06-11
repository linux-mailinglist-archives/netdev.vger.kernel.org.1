Return-Path: <netdev+bounces-102719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDAB9045E8
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E721D28823E
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 20:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FEE154449;
	Tue, 11 Jun 2024 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A491lRRp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CC5153BE6
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138574; cv=none; b=rP9YCrwEc9TR4O6osBLlivSqHQvn6df3oqmyYkPSgbl0Z2pUDlDoYjcZHDEdCW6HTsRL1QL0ZZEGGJjpCUr9uMaMN0nZ1DUqWQHSN5yjfD7Q9Gdy1I9SiyZm5VyxPbyPsniTfOOZRtZPGUkhSwwoRqUTLQOUlR+wHFwEodjqUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138574; c=relaxed/simple;
	bh=ZC3jwVHmyjA9T8vj/DUPMtjrMTI5ggbi5bhcu/zigYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DUN83xjDsoNhqw5UHj/BQHPITZz/gD5gg0Qa3ROY4Bddl7O0h206Mhi1lrPBHmAjreX/O5bZxqqmYm9F6FunqYkzoLobG4Zc1JWULXuPO8V+xl4PZAYblVL+7cxshgzUcixdmcuI2o3ti/66QmbIN2hek1cWr4GpuoeR9Ilnfkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A491lRRp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c2c5bf70f7so4266331a91.3
        for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 13:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718138572; x=1718743372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OqCPL9U8ZjSxymP893fgGbwmQErYRpVw5HY4fXwQBKg=;
        b=A491lRRpePWAFoGPXylNpNRFO/nYIQ5ZRpfGe0rwcbfeO9HBjXPGmC6CZuAocw6Men
         LGVkh9k40v5mLrPHjok8yQcNAFW0XHmk5J5dNETXncD7vzpUxPhywXMy3l1Dh1lFvaKQ
         n6ih7UNZdFoDX+5iKoRbRbLxXZLywWMD038rEKdmN4KwrdLTRVpBrSCatGt/ijRRacF5
         THbmAD/eO0mrcObfs+ziuDdUyPavZDTlhtbsPwFAM+y89dkAM/QrZqtRd4wmaySMNSZG
         B4sVs5n2wPEzr1RWEeeMPdBor7mwxhIqBmUhcEOZ6p7EuUr7xLFPFNIR8RGUFKutA0qX
         G/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718138572; x=1718743372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqCPL9U8ZjSxymP893fgGbwmQErYRpVw5HY4fXwQBKg=;
        b=hH8MQROMQeDfd2rA1QYtge/eRIaXWYCenQiq380BlzVCCfFVy3o1tkL19jbK4YYIp6
         jbaTAirwLjm50xrAHlgE+uNxeNq7LqykFQtZKI+8y1o3LmDO0sjZ4RfmsHB3JV4RwWip
         1fSsAFaZRryP70NdqgJws5EQfKS+ZTwhfFC07tJExVE+DFHjvmvMEerIOXOktubY+ZN1
         4lsGmOhpIP237Mz9fz951eDj5a0N2UQW1nZl2LzfAifZ0n2ApHyGmYEJBjBVL/MLTQRW
         7ugnZ/nBv6B+4TJvQIDInkgqZS9ueL7fG0HJvkU0qGzn8f+aiIRBJUHad5+bgN/hP/2d
         +6NA==
X-Gm-Message-State: AOJu0Yyc13BIiLcyctCPtsKJFq3e+jsWNIuQI4UqMx3uhMGtzOlne2PK
	OmvO8m1vd2jJAHPhLAJb4RqQrjqn/7OTJd9mD2J6LYNdL5pp10rtpXhxmccA2w8OwH72N3qunVg
	65arsBurUAJSIFVnxjO9Xzw10gyEqaaTa/sz3rg1i+cjzWlm1LLQgXt5tIxBh0IZaB7+UJDgLxI
	Uw7iL+byDqTavTo+QEPBMYJd38OzseU1M/DFZ84Ki8WkQ=
X-Google-Smtp-Source: AGHT+IFDEfAtRtZOdGNFi1pbAoLZ5KhgCvdrpSZBikYHlmGgYYbmSU93y8fD3QKM92tfVo6BlDamZdgVW/DDfA==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:90a:db8f:b0:2c2:e420:f42f with SMTP
 id 98e67ed59e1d1-2c4a7606f5cmr89a91.1.1718138570783; Tue, 11 Jun 2024
 13:42:50 -0700 (PDT)
Date: Tue, 11 Jun 2024 20:42:45 +0000
In-Reply-To: <cover.1718138187.git.zhuyifei@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1718138187.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <a932c40e59f648d9d2771f9533cbc01cd4c0935c.1718138187.git.zhuyifei@google.com>
Subject: [RFC PATCH net-next 1/3] selftests/bpf: Move rxq_num helper from
 xdp_hw_metadata to network_helpers
From: YiFei Zhu <zhuyifei@google.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

This helper may be useful for other AF_XDP tests, such as xsk_hw.
Moving it out so we don't need to copy-paste that function.

I also changed the function from directly calling error(1, errno, ...)
to returning an error because I don't think it makes sense for a
library function to outright kill the process if the function fails.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 27 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  2 ++
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 27 ++-----------------
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 35250e6cde7f..4c3bef07df23 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -569,6 +569,33 @@ int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
 	return 0;
 }
 
+int rxq_num(const char *ifname)
+{
+	struct ethtool_channels ch = {
+		.cmd = ETHTOOL_GCHANNELS,
+	};
+	struct ifreq ifr = {
+		.ifr_data = (void *)&ch,
+	};
+	strncpy(ifr.ifr_name, ifname, IF_NAMESIZE - 1);
+	int fd, ret, err;
+
+	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return -errno;
+
+	ret = ioctl(fd, SIOCETHTOOL, &ifr);
+	if (ret < 0) {
+		err = errno;
+		close(fd);
+		return -err;
+	}
+
+	close(fd);
+
+	return ch.rx_count + ch.combined_count;
+}
+
 struct send_recv_arg {
 	int		fd;
 	uint32_t	bytes;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 883c7ea9d8d5..b09c3bbd5b62 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -72,6 +72,8 @@ int get_socket_local_port(int sock_fd);
 int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 
+int rxq_num(const char *ifname);
+
 struct nstoken;
 /**
  * open_netns() - Switch to specified network namespace by name.
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 6f9956eed797..f038a624fd1f 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -495,31 +495,6 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 	return 0;
 }
 
-static int rxq_num(const char *ifname)
-{
-	struct ethtool_channels ch = {
-		.cmd = ETHTOOL_GCHANNELS,
-	};
-
-	struct ifreq ifr = {
-		.ifr_data = (void *)&ch,
-	};
-	strncpy(ifr.ifr_name, ifname, IF_NAMESIZE - 1);
-	int fd, ret;
-
-	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
-	if (fd < 0)
-		error(1, errno, "socket");
-
-	ret = ioctl(fd, SIOCETHTOOL, &ifr);
-	if (ret < 0)
-		error(1, errno, "ioctl(SIOCETHTOOL)");
-
-	close(fd);
-
-	return ch.rx_count + ch.combined_count;
-}
-
 static void hwtstamp_ioctl(int op, const char *ifname, struct hwtstamp_config *cfg)
 {
 	struct ifreq ifr = {
@@ -668,6 +643,8 @@ int main(int argc, char *argv[])
 	read_args(argc, argv);
 
 	rxq = rxq_num(ifname);
+	if (rxq < 0)
+		error(1, -rxq, "rxq_num");
 
 	printf("rxq: %d\n", rxq);
 
-- 
2.45.2.505.gda0bf45e8d-goog


