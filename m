Return-Path: <netdev+bounces-157593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC69EA0AF3F
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9B6188601F
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425A7231C83;
	Mon, 13 Jan 2025 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mr/cOPQh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD932145A16
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736749127; cv=none; b=jg3sf92cW6fWjv0w7JFRHYtFS9WhAJN8mPDdyAV0KYdaTICYVrs83I4Z4YRD5hd1LQLl5MCFhz6EtDHQKCg/93sAHHct8dPEzP9Ce5kqc2EkftJib2v7EFKdWvjT7rlNHaq3jeYBffSYXpITimNI510imtCRmlmlfvMdOlYvHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736749127; c=relaxed/simple;
	bh=LUrrlU4BNkR/ay/fSfOJeTi1DTX6YT5sJQ7H0bsPWk4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Yqlmbq7Ck2sW3DN48pY5fzSKCxYw1wvkeiE4esyusxwNNPJpep1xvRpXRAQR2fy5+R75hrz/o1lvwZvi173V1z5oEontmbf0LVSI2htuSzy/4AM1WPY9zI5boZ6Oj6Ejwm7A4SufDXyL71xLkdweVzSWpMYE+0YyVMLrebGpkj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mr/cOPQh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d932eac638so7474807a12.1
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 22:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736749123; x=1737353923; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6S+t9FaG2NoF2nwQgSa+JvhqmiyhhbiLGkuYyDyovfo=;
        b=mr/cOPQhgnEwP9P4rcQmeR2eP6cfh2iLhzQvXZBMr7rB2iXcRM12k73s9jnS1Bo/Ry
         u+hXS6sGlkDrk5miIYorX/3xDOfZBm9e5TZxuYkhnbQlmucNGHTTyI9uywbgEl9Pgaqc
         U6NNGCRA2vUmJbKCussoS3SCbTdwP3foSRIUXtBD+wrgl1VzS20Fm2g9aFX+7dr787sM
         xBHFQPAvCQ1J8qr/NU8i44D2hFA3NqA12H5zvV7K1MQjuTfUaVsEuT4RH1XlCNticw0W
         MW+TqN6EfpvCfigoys+InJLhe19/M8QoFzrNzW53kB+7CfgFYoRQboDBbj3uqfSiYsb2
         iJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736749123; x=1737353923;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6S+t9FaG2NoF2nwQgSa+JvhqmiyhhbiLGkuYyDyovfo=;
        b=Ybupe20SY9dchQR4IAvkB710QZbzlXb3wcpmfQOi0twfgeQPMbsKUxnI5FqXlChEiq
         Gal+3L/ailLnv3Pj8ywvl8DpjKIbt876d3y5MwWwFE8qTtoelIpg77d5oEPRnE1MnKd4
         NbCQnsY3TpAxzHiMqpDAQ6g6Qdo142g9OS0theFo2Gcp73xHpE13Fkz7qE6im+42WhJC
         3Zi47LfVpC5g6pYjaJlGIPOKzi+T9XCzaQCcFY6JLYECoZjgxGR9BEtu0//YDBxXIfeV
         xlQpPOY1o7CeG2Qd+RNk8AOR4kiS63kCKDYnUcSc3Hv1BO1kKBaupZYmmMSBc3JciVmo
         e8LA==
X-Forwarded-Encrypted: i=1; AJvYcCW2n6oLYyYastE1L6CoLcdkpNTfEmWNc7W9jA5+Jt25Sr2fhm6BXJuMEOHHThRRcAJQrss8wio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCctw3rCv1sULsVkZN2ga6pLX8bNwksh2uXobBoROgJF4QY9w1
	YYBD4grMht/XQ3RKN6i/XcRdiBlcshPs60OcEpWarJ5J8sph5DtEq231Yp7BoP8=
X-Gm-Gg: ASbGncs75JcGKGIgWvqHV8kQ2HiUIWP/0X4V3fXNTyR350fTb1FlmqNRBagrnZuhsSK
	eqB+MKO9GhNbmso6b7mgktnn+4PQQGzGhBZQY3vh6m2KUNm4lzt5ZJXs4vnAU7WSH0j4XzEuYoG
	zU4Ad5gm7DKLPIAhAyTYeIlwZGlI1AnuvQoeycuAFHWmrHJaVrWr3zbjEj6TZjSTYIeFqjPRr6G
	1V+A0O667J5NOeQNSLyYIGh7lAKwncAEesIrXFpNurAJHUF2aCjUAimRGdxCA==
X-Google-Smtp-Source: AGHT+IEF+9I/nmlTuNhL+jsv7WcG7fafEtH/1G6wbIJb2hKurpya4UqUE3HWDQiZJqimw76RM48otA==
X-Received: by 2002:a05:6402:34d2:b0:5d1:1f2:1143 with SMTP id 4fb4d7f45d1cf-5d972e1a602mr17851264a12.18.1736749123084;
        Sun, 12 Jan 2025 22:18:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c366sm4523124a12.17.2025.01.12.22.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 22:18:42 -0800 (PST)
Date: Mon, 13 Jan 2025 09:18:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Louis Peens <louis.peens@corigine.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Quentin Monnet <qmo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] nfp: bpf: prevent integer overflow in
 nfp_bpf_event_output()
Message-ID: <6074805b-e78d-4b8a-bf05-e929b5377c28@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "sizeof(struct cmsg_bpf_event) + pkt_size + data_size" math could
potentially have an integer wrapping bug on 32bit systems.  Check for
this and return an error.

Fixes: 9816dd35ecec ("nfp: bpf: perf event output helpers support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/netronome/nfp/bpf/offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/bpf/offload.c b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
index 9d97cd281f18..c03558adda91 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
@@ -458,7 +458,8 @@ int nfp_bpf_event_output(struct nfp_app_bpf *bpf, const void *data,
 	map_id_full = be64_to_cpu(cbe->map_ptr);
 	map_id = map_id_full;
 
-	if (len < sizeof(struct cmsg_bpf_event) + pkt_size + data_size)
+	if (size_add(pkt_size, data_size) > INT_MAX ||
+	    len < sizeof(struct cmsg_bpf_event) + pkt_size + data_size)
 		return -EINVAL;
 	if (cbe->hdr.ver != NFP_CCM_ABI_VERSION)
 		return -EINVAL;
-- 
2.45.2


