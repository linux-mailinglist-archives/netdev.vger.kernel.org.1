Return-Path: <netdev+bounces-230951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F02BF2499
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 18:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B6B18A48B9
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021B22836A3;
	Mon, 20 Oct 2025 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSZQ+0Nb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384E1279DA2
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976188; cv=none; b=scii6uJQy7qBH5KzilhU+vFdFmvQSTB04IAxAhreJKKaqbr3ZX2sf5HESdw/Edi7TrKSu5AeQrU5Z0R18CAxiBK1ThIqjYiQZjIPE9uos0c9aC9HE+dO9b1vhQgqAK59KfLfuS972KchVFGvuSi4kH3eAIf3SIx6hfH8FnH5l84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976188; c=relaxed/simple;
	bh=5p8QM8GiyJ3VdJu3v6HqAWTAumRdDRF9TVX5rxrWIhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q8K1AP26o4nUf49w5Utxu8nqiMxX0OOvHgToLTnxrFcr7CI3zTnYrqaktbw522Tgi9p2KR8SmnvuUafGn1Vsb7XHfO9aaO17NgpNe7yV2LBHS4qgYdPaJTzR2GmIZhnNRHKAryzvhBnrbh94U3bFMeGmC6SZUtaq4jcgBaq0heE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSZQ+0Nb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c4b3a6f71so239705a12.2
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760976185; x=1761580985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sEqKuO9xbs7T7mcjnW0UyAFwwa+u/P82jsf/ebmJ8is=;
        b=RSZQ+0NbRoXdDDj5kghqrTLTE0n738dfH+i25XWUoFMviFBQE8FYET+NCWrlrHgTZ9
         z+C9NXTwtFkWzaEgZNktFuQIET0GrMTW1QODwazG0CVJIiJJ69OvZgb3dmTQIBFumsoq
         ulV09kURZwM9jQdmSq/d59a+PRbLeN9/4G7AByj2NGXWQfdfqSEZsLmIcLtXod+KmQq6
         /RhNJahfWxwTcs8nDlfmrMJIo2x2AU2dloBkxUzXNlm6DJ28LoDLFHyoX7NMxXuLCg2S
         UQ+oPPhKmp+QETX1KP7ra7FRd/SzBLAgTegLDc+kTLrz0fUopet2+Jk5vURfL35UFVBn
         xiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976185; x=1761580985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEqKuO9xbs7T7mcjnW0UyAFwwa+u/P82jsf/ebmJ8is=;
        b=cYr7gqCrzAqTYtt3Bpi2HNF9mW9Ft8NvKh0kCNkV0uC4n4gqLwNrQPhXx3tN9xELKD
         3QRhaVhzNJqq4ZSGDStONk+TSz6cmwwCAsEU6skmJ+2MD/VoNySQdLlBMsLGYFVx3sJv
         c0QfPbKXPXZ9Pxb3NuikFlw5LclmsKSn11fI3C/OKg+JHERcgxF2CjEVKUl2kT+a5JmJ
         balljRFiWJjsn5QMROY2N7TjwFqW+hPXyJVBjkJaavxoZcoZFBHmZuEAHTXfb9RGpJYL
         G3KfAvW0Ms14dE1sa8M1CTXnE/cnatENaZgbkXcJNDTaPYYRrD3CV+h+oFLJfyrkFOcT
         yujQ==
X-Gm-Message-State: AOJu0YxhWmClVRaHv0y+JdYvJpvGxbrNp6HLUmBgD8hZ/sQI7IOJi4NB
	gsglc01o54/qVIvK49eQV8ZPoiQe5s9yLoAOW55ievjz2GsxMYc3j18b
X-Gm-Gg: ASbGncvKuaHhYGBnlE0Nru15k+PGXnJWEWbqF4gthe2SY0hPnend2b+Ecau1ydBpP7U
	rsakhQHOYr6XiDSOGPQtMm/DNAJJJDZSOvY/4xP6Q0JKhEZbZv4jB2+xlSsmADkbg7odydi5IDw
	/DWArLiBklC4MZocMSG5tASOT/ll7/xVQcqIwq08nZgfZtpQN1NrNFAlo1nolbGp6repkIGrYeP
	lYIa2u/M8H33AsmltZcTojBfa0Or7UxhaEu+RI24TMtVDeaSxcObD3YojZ8LvqVw4iuGd+SKGtf
	L/ObwQ0IHP3HEQZREK31SrTAXAcaoHh64qZfUPum7nE2uQIXET/ERcjttHaTirfRQ3OjBi3i+FA
	2OKUFtDPUgVxaWwkLa7HlFhu1Mj4Z3t3p2ornIooiohml7jc1r0dixDfZKBJp1xcF6KUNoOuK9n
	14Jaeg8GRt7tKBfQ==
X-Google-Smtp-Source: AGHT+IEAZ4aDtO0vMHq0WUMhe05mN+O1T+el3SwZMkFfF983mLEGTQdhOfy2UfAjoiXHE/Y4G+rEjQ==
X-Received: by 2002:a05:6402:274d:b0:63c:343:2493 with SMTP id 4fb4d7f45d1cf-63d1649c390mr29994a12.0.1760976185195;
        Mon, 20 Oct 2025 09:03:05 -0700 (PDT)
Received: from bhk ([165.50.86.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4945f1ffsm7186665a12.31.2025.10.20.09.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:03:04 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH bpf-next v2] bpf/cpumap.c: Remove unnecessary TODO comment
Date: Mon, 20 Oct 2025 18:02:37 +0100
Message-ID: <20251020170254.14622-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After discussion with bpf maintainers[1], queue_index could
be propagated to the remote XDP program by the xdp_md struct[2]
which makes this todo a misguide for future effort.

[1]:https://lore.kernel.org/all/87y0q23j2w.fsf@cloudflare.com/
[2]:https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
Changelog:

Changes from v1:

-Added a comment to clarify that RX queue_index is lost after the frame
redirection.

Link:https://lore.kernel.org/bpf/d9819687-5b0d-4bfa-9aec-aef71b847383@gmail.com/T/#mcb6a0315f174d02db3c9bc4fa556cc939c87a706
 kernel/bpf/cpumap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 703e5df1f4ef..6856a4a67840 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -195,7 +195,10 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
+		/* The NIC RX queue_index is lost after the frame redirection
+		 * but in case of need, it can be passed as a custom XDP
+		 * metadata via xdp_md struct to the remote XDP program
+		 */
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
-- 
2.51.1.dirty


