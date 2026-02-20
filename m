Return-Path: <netdev+bounces-259636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9WgtIN/El2kN8QIAu9opvQ
	(envelope-from <netdev+bounces-259636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 03:20:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC0816439D
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 03:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 967AC301E6CF
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 02:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA952274B37;
	Fri, 20 Feb 2026 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSAVGlQh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E8233D85
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771554010; cv=none; b=SFuoT9IZoxdfghbCq5lAZmhef+uMNbHGpfA3vGENnqHBG1mV6sAKmeityD+BwaWI1nkGu45JYIyOGz4ICiKHk+UV1Y6eOBNdTvqLHfHHdG0NVoMNjrngzoTsfqkYL4+PHfuq1uW6DdJBGuDeYhizpdEm9X4uc73wFHOFVfE/4Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771554010; c=relaxed/simple;
	bh=d16oDPNBBKySZVJTZAuLIhPRVmR0IioTtcIbfET7ASc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N5t5poSgUjGgZNcwgvulwKWK2yDUdYhPmbxAZWdFdcMGX13RS/MqDzzdBn8izkhhAEnDIPrfiDwkqr22RYOJJ6HkoC6uPN4wlmogj10BoWDhQV9IpR/q4Rd4EL1fZqt+Z9vSztOdT3aWInHskEKqARPkNcSzee/CRoe9AjBuadQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSAVGlQh; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-797d3864d89so17953057b3.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 18:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771554008; x=1772158808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JvWDQd8kefwEaqMMYkm4D2HK6neFrO40ilwGSEerMMI=;
        b=WSAVGlQhxx4iuLVFCeHBskoJbVmDGa4ByrdA27Em8FWTR1BGbwMilQNb0UFySVhKop
         aFZ7NfuMy8fHKA1Yo/TRNCPwYA5Gb+Dv72IHAQKMGwPYxxd0DE4AYGb/+Kopi8haHsL6
         BpyWjI3xhA/Wv9QJf9BrdR6Pz4zTAaIG6/DNeUAKhLx78fwa3ExL1NS/EIx7VDN/QurI
         wE25PC9G68MkUKvkkqC9PsJ8wXzReVVntEKn3lm8Q6ZW7m6PrCun5Oy9IVDYMP11tiub
         0U3vIMF7tN2i4udROGBcift7HJ8YeKAb8iQSxL6iW73WHMOx2s3B/hUk+gowbex+IGx7
         tCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771554008; x=1772158808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvWDQd8kefwEaqMMYkm4D2HK6neFrO40ilwGSEerMMI=;
        b=Dup/QY0n439oDHoFP6az8/f14CAWPnj9LCPUQFjYEuFjqp7zCPZPAwnZrUCgLscscB
         tbLzq5sxWlylHosxvu8mSpkxdMu6yx9bu4DxpAiHC7/IrRWSL0UNC2CG1qrvldKNTr+p
         7RtiRhyE2ld9oVT4+rNmcA2t2GRCtr1rjvG0Wg48u/fzgODR4QYdpinKKjkdzgR9yJnH
         OZU1UXDeWor9HqxIDi+q8zUo7m6pgvep04IqDLjB2QEQrU9KV8LzNIK5CAcz8975IUoG
         5iT+q0L8TdRhWeRVIdN0QM7X5hQIzZIvBEWo5g+MoCY+ZnEIwyTVEhco1KEwYq9TPRPL
         YtFw==
X-Gm-Message-State: AOJu0Yx6acDO1lVyUucBiTIRhoxAfBSsg7kFR/qwd1mff2HLa/Ppa9ij
	8XURqal5PRt3Al7DCZaPh7Ixr7VTuEK4rGI0sUGFlHzPkApNffJeawu8R3RFX0n38rw=
X-Gm-Gg: AZuq6aLCHjoxdi+jamJ/QYTsVllyE1n3j89fSWx1wKCPEXM1PAGnE+dl+nzgO7TOi2V
	PZ+FJlrllBo7Ng4uLWhfkK65AOJ5FpxkiC+ihoaz0FfNSzuBfZQTGsYOdn8b1QAQTAgrMP4OXoC
	LP4+uRE62CCravXptRDMYM+GFgtqNXszdxADmFbftBiBZiB8sLWhAWaLAwLN1K7LcILhWms2BgH
	7d5nraivWCHnqwWLCUAWDxEW+IFuqjvwP/l2t125Zb0kFkvWwGcUUpPycHR889I0/HFvdN9Kzx0
	G2hS1zExAOuEdlQMiI9IwYnWMuqqkRDbIDQujudcUY4HSdROSXuhoFF/fQtYboWHNApDF8oHuMG
	zmhX3121lKTJ8xkcJoTBe6oxua8WcVIkMwBD/wfF3LE9h950w6G0/SSbQnEdfPeocDNew
X-Received: by 2002:a05:690c:4992:b0:797:a27b:8633 with SMTP id 00721157ae682-797ac5cd220mr174743647b3.42.1771554008222;
        Thu, 19 Feb 2026 18:20:08 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-797d142c2dbsm45550347b3.47.2026.02.19.18.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 18:20:07 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Linus Walleij <linusw@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 0/2] net: ethernet: cortina: support deferral
Date: Thu, 19 Feb 2026 18:19:47 -0800
Message-ID: <20260220021949.40817-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[googlemail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259636-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFC0816439D
X-Rspamd-Action: no action

When using nvmem, it may be necessary to defer probe until the specific
nvmem driver is loaded to get the proper MAC.

Rosen Penev (2):
  net: ethernet: cortina: use devm to enable clocks
  net: ethernet: cortina: fix nvmem mac addresses

 drivers/net/ethernet/cortina/gemini.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

--
2.53.0


