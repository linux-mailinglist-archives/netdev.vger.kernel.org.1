Return-Path: <netdev+bounces-147446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6E79D98E8
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 14:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAEB165687
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B571F1CEE96;
	Tue, 26 Nov 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="RDYs28ba"
X-Original-To: netdev@vger.kernel.org
Received: from smtp052.goneo.de (smtp052.goneo.de [85.220.129.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B240946C
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629247; cv=none; b=gXYpRSKgNi/tpY3EgGnAqC87Hda6KSafWYHtXRzXHBELa1a7qfqwYq9QTS7jKnCQGfvOY4pvkxplo1q19LMCSR+Z+77I3B/1cmwd9RLc0Tu1SemGyzYf8nVaZJub3e64u800c8+QXVXJU30AHel8j9LhGnRj9wKJ0BZSHem0qe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629247; c=relaxed/simple;
	bh=/tzQ7FckYyoh5uNAcCY1jPw9rLxUwoRCr81psdSfSMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ciVRRU9INYiAnZtcONO9D37B94RWVv5/7OAvI858EnserzRT3PZuh7AK9duo13Ct59os/4VPX4hV+i5xiuXvHKX5WjYf7MR+12URZQLJkOQsHsI+rPBpgUWSp4aAN9YCLGdDW5CPlh4Lcs2FDReC+EiTQStr0Ceytb7wJjB93jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=RDYs28ba; arc=none smtp.client-ip=85.220.129.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp5.goneo.de (Postfix) with ESMTPS id 8FF28240E4B;
	Tue, 26 Nov 2024 14:47:50 +0100 (CET)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id EC42224081D;
	Tue, 26 Nov 2024 14:47:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1732628869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/tzQ7FckYyoh5uNAcCY1jPw9rLxUwoRCr81psdSfSMs=;
	b=RDYs28batdwaGpA8Crz0VOcB/IVWYN+5Vu1GfDLr3lObUiaMc4n4IXh2rSWoAzR1jNUemO
	+kYtoBMVEsEZfLtKEeNhZnqiFNIbfL/AHy8bYVZYxuZ9fhBVNXMnSatL+9OcwWXSZTrphf
	7hRa7QUvPJjn+xmy8NdaoIxWgqmnfAHeywiXlr9jEhH+UR+f53T6DEdBoLdS5HX5BHtC5P
	7ICxqkoE92uCf7GUL43Ul9TmX/L6vlj5suwGeL5s9avNljSfVbrVReKQM0B314n2k1EQM/
	H5abfQklQ2eEiBxUFDUt1c9WjkV8d/KnW3yHlr3vonj0ICNDPcu/tHHV4It1fg==
Received: from Til-Notebook.hs-nordhausen.de (unknown [195.37.89.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id C0A8F2405E5;
	Tue, 26 Nov 2024 14:47:47 +0100 (CET)
From: Til Kaiser <mail@tk154.de>
To: nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org
Cc: netdev@vger.kernel.org
Subject: [PATCH net] mediathek: mtk_eth_soc: fix netdev inside xdp_rxq_info 
Date: Tue, 26 Nov 2024 14:41:53 +0100
Message-ID: <20241126134707.253572-1-mail@tk154.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 15f699
X-Rspamd-UID: ac0795

Hi,

I have noticed on a Banana Pi BPI-R4 running OpenWrt that the
ingress interface index is always 0 when I attach an eBPF/XDP
program to one of its SFP ports or its switch in native/driver mode.

Attached, you can find a fix/patch and a simple eBPF/XDP program
I used for testing.

Kind regards
Til


