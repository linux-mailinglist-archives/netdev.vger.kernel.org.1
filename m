Return-Path: <netdev+bounces-264182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8No4LlcMqWnm0gAAu9opvQ
	(envelope-from <netdev+bounces-264182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:53:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B56A20AEC8
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3871E30440B5
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 04:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D42D286400;
	Thu,  5 Mar 2026 04:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8h8GyqD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6D6336891
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 04:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772686405; cv=none; b=L1Phz5I9lTvp8q4G/StXRV+XtZfQn1/ic8hBoTAC0JQxwk5jzhSCozn4urKw91GANkRDccSb4zFnd2/DWpSXO3m07Mv9Ui79twII2SpoKq6HRxbUBZ6ksDZjgqgSSV0llqpixvtgSKqWmSRzmuywR0Ceuap1tqDbsCMrdTe9Z1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772686405; c=relaxed/simple;
	bh=GLkeSAgriyZBAMLi++CxXjaSQJZ6wTgjQUF1CIfwHwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLgdCjafmO2ru7FmdYnhp13gLWPG3zuskSo1THUMkj/wo7byfnWJXaDD7hZeYXuShSWOFyms2BD9BM0NIshJ5QzAVYRrjWMC9plemgcFU1QR80kpwwW9XrFyHNF0hG3aOum2IskTyRclp9PLRjuMUeiM0PPYPKXIOSglZqA93Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8h8GyqD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ab077e3f32so33437665ad.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 20:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772686403; x=1773291203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLkeSAgriyZBAMLi++CxXjaSQJZ6wTgjQUF1CIfwHwI=;
        b=L8h8GyqDX1Lm45y83CvHSMHOR9AwYJP4gw2us75Lf4qDCPSXhQTeljD8agaXhQXBGg
         WZaTjGpIqk1RSm3DyqxR8iE5+B639z9MGugdgcWYyE/BJRzhBYlQOyGNEOCtf3DM9/+S
         FcxFxZ57zPdBLHWAG4vDPqw4LkYEv7m+p+U3WTNnuYoIdQGltq7A+2B424cALFC9i+v4
         oh6l8Ejze81d+QciFX2PuInbBjgcCR89J808G+TmxCxf8wOqBUfZlrkRiVLKFjyfgAAs
         /3SNxIDd/KWZ/ZV9SyWpEffw+cFztsG8WjBy7enBzJ5gQv3m6v1grdOYOZxh01dXJ3xu
         nveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772686403; x=1773291203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GLkeSAgriyZBAMLi++CxXjaSQJZ6wTgjQUF1CIfwHwI=;
        b=WOKdMqAAfjALVx58LJwAETkSDY140xI+QE6qP+K6c09UwW/nxOV40/7e3NM4DwyhYk
         T5n6sXsL8yg2uwRZ1xchgmKZrzldh72p533w5k7GDbNu0iTQCFouUmeWE0NbuGetP5LK
         lQXepNohRDSgqqWqA1I2zhDWNhZftFgU4YvsKeuRKBmMt+dyRgTQezwerTWJzB99EMeh
         y/jhw8A0TacO6vZBCxVYaxQ0aNj3zw3QbXsmULEEtzEGZbRh8N5NSEl3uUif7mbdMonh
         86joVxSymYEsyKw5JC57ipu4NGU/XmFqYsnxjB2HBQXVRr/2jmoXkJ9OKZSqZmJPo0QX
         eUKA==
X-Forwarded-Encrypted: i=1; AJvYcCWbSYTs5y6dAcA4WBIyXTdRKoGWWnvCEXvawuj0BnEgoN5qSZ83rphsgJDFxCLL16vH7sjJtEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQI2iP7GwLOhZtKTCBuC1TyrrS+Yvjim6chaybIc80eL8n4dur
	v4x39PVqjJaQEPfdxP25GZMEQLEFSHWAmlqjnzx0B1IgURtenL41XDrI
X-Gm-Gg: ATEYQzzksPiTTC1YJbIYW0lofC89XRfVWcN/L7uNZDMoSLNt6n/ZGPsjGRlATjNBnhs
	j1TSPKOUcH8EMfxOAqKzFmfJ7IIOlMcPbxBDVx4o96cuKbzpyIbcFrNuFgIipfVzFODLPA6CCeC
	UhzUPe+lYZSAvJD5sV9XvYZ0jVsT9UrI6jAgPhhseIA75WcvoIRKS5O/bRSu4fy8AHfCdfw6zj+
	HwUMWohFOt1jLJbA/UoUJeyXPgtv/01eW8Ny3O/072ZSCwbGnQ4qOsjbnjlcrrNiB4i5GxE0scr
	bdLwJW+MJCG0LhMJFKCWpznRBnFPHEh3tZcLcQjrE8GuUbCV/SPBlxUhL5CHsZCBZwXArRDbpMx
	6CJTspbeqJFVRFdscnsFRulEWiDsqbaZrSj/HLagauXOxt/BISbRXHDB5WH7hgAQkzQK2TMoDMD
	bTyGhVhYx2P61ZC3ZBw8BFq7b+MhRUlyo+PCFAE4thPBR/rEJH739BWWkVG0P9Cvs3pqPX53kN/
	WaD8WSQxvju
X-Received: by 2002:a17:902:e752:b0:2ae:5039:a073 with SMTP id d9443c01a7336-2ae6aa2074emr37963325ad.13.1772686402863;
        Wed, 04 Mar 2026 20:53:22 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa43sm211493005ad.46.2026.03.04.20.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 20:53:22 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: kuniyu@google.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	jakub@cloudflare.com,
	kmta1236@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] tcp: remove unused hash_size from struct tcp_out_options
Date: Thu,  5 Mar 2026 13:53:02 +0900
Message-Id: <20260305045302.96132-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAAVpQUDy_fLy4TQNfJbqj9QVr2g=_bykiH7GSQQRjtLTT0SYyw@mail.gmail.com>
References: <CAAVpQUDy_fLy4TQNfJbqj9QVr2g=_bykiH7GSQQRjtLTT0SYyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B56A20AEC8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264182-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,cloudflare.com,gmail.com,vger.kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[kmta1236@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Thank you so much for the quick review!

> btw, AFAIU, patchwork does not use git am -3, and this does
> not cleanly apply after your another patch and you'll need to respin.
You're right. Since the first patch (https://lore.kernel.org/netdev/20260304111517.2088694-1-kmta1236@gmail.com/) seems to be close to being merged,
maybe I should rebase this patch on top of the first one after the first one is merged?

