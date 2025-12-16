Return-Path: <netdev+bounces-244945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB32BCC39B6
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 15:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6B393070784
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 14:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB11434B187;
	Tue, 16 Dec 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NaJOt6E/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRYZ1uOd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C659834BA5B
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895241; cv=none; b=jscFzDz18mOBCy4Zp2niwm+dQnf473eLxI24BaWk/zIp8lygBIYQy+uyqKTgdz4a5WlIVstRgOjQsZe4BIsayz9u/9Fp4nszNyANpDizeoC3eF18lZSVBuOg1kOAaLmT1oyfdn4WY2IWQEWcXXVyz0/QvWw3vs2agZVuhjq3prI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895241; c=relaxed/simple;
	bh=bRJifwBpOn5/UKOhHLvWKxzpriP409m/28t9c1F6o0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXM+GRB2dgoaHITwMVXtY+Iz3UK9H4Jj+taPNpprM9Oh+Cuc7YbdXZ6qOW1J3ucnKGyVI3kd2DGBifUHQFJaxKn117MnsdzznWhittDI1ptH30hIfRorAmfdEznFKdG8r1BDTxpxFpwTbJKENul7nkYtzK53hpukbjGna8edl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NaJOt6E/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRYZ1uOd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765895238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRJifwBpOn5/UKOhHLvWKxzpriP409m/28t9c1F6o0w=;
	b=NaJOt6E/djq1elS+Gk+sWecNeqi9AvJ4j6yluOIStCQ5Mq6xVA+IQQLliAG02vwpeGHhiJ
	Fouw17WNQ78LLXE/dhHBQYSPEFfm0FUe1fItJK/mtc/w1MPImVrwtmDifgCze5KTNOwfC3
	VyOF6jCJzp5USn5lVv9Gr2mLE8fVTpg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-h_woGwXJOz-EnkLF84WWnQ-1; Tue, 16 Dec 2025 09:27:17 -0500
X-MC-Unique: h_woGwXJOz-EnkLF84WWnQ-1
X-Mimecast-MFC-AGG-ID: h_woGwXJOz-EnkLF84WWnQ_1765895236
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430ffa9fd7fso1085243f8f.0
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 06:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765895236; x=1766500036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRJifwBpOn5/UKOhHLvWKxzpriP409m/28t9c1F6o0w=;
        b=hRYZ1uOdayBnW2Ulj8k40pc1ECvNHLMa3sjwPFxr1EPLWXsM/tLGSntVBJQM1LSFnz
         HBDqrl72iTVElSS++337DW2Ephh1SdlIZxLHeLxvzRHbUvMIoDFReGTRx4BJmgGsKvTN
         /pCfsBmFG8O54y0HhxjNTDAkMsVwglr+s8srucEdp68ljEjshtTk8ssjhWlxmiH4jjA+
         d2jEdfABW+ItFK60Z0SY6/hSUQbIpoJ60Unp1gU+WDhk1G5F6zhLWYm/f+tr1tLt6rOz
         pqSlElBV2pHsExz4TiL3W/p9qnHMSh1+N1y2T5G3ERmYU2+7bmc4a+h/l9yndgIoR0R/
         hAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765895236; x=1766500036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bRJifwBpOn5/UKOhHLvWKxzpriP409m/28t9c1F6o0w=;
        b=M0W6cUduv62v1QZ5Jd38doVQbEX/x2dH237RLKtl0NIXm6RogF/VucFm9/wwtSMzwP
         8pLkUVHDTwpbfXB0XMSmDNcXtSoMji1+sb5CB2WNvzzKqckBnJIa7vHJLj8gER77PJ9V
         U/R5Jy7NmIMG6unM5EBNk483LdauoF7d9ns8JUZWB5jWivEO2QjnOoLX+IRhJU63xQF8
         WMqKoxTRAPeuOC/L0xbC1TbipaEg65fM9A8k5p2iXX9loHAFNs/Ukj6472zddOD1gIjE
         IfvcjHHI8LhBOxK9ku7MybeSKHDftlZPgsYBPXAm8jQL/BAYWpjnR7+Q5A7a/SSDITkV
         sI7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfCoYqJbbjPtfuEaE5xrnBDf/ObnH2mxhO4j6vj6LpHk7sPjoGmM54joDtouT3P1KnKYSdjv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgPhEcmJ1I1O718BHN33J+p/j4TD76Jgu9vysmfDZr0XtURy2V
	oKTSETZ5rxwv++ysdtmioKe8OFx+Y5xrDOpRADXp0UXJnZ4Yla8hM2RXO7mQ5sUywMPxJ6uSZIw
	vJgyk3bT0/6Ft7Fe1LCIQXH9aMWXndxA5iVrCnrxw0IgqbcAjgq6oKgVtUA==
X-Gm-Gg: AY/fxX5znrcMLlGee10bzhM+YcJ7BybdFGGIMhCh0HS7SFIjmiJbGm80H4IVusHa8kn
	dzWQGgN6zVsYtVc9u2uU9JiaTiL0NSYd63+YgMwSx+yBRpSgwlgIrWIdr6MMMl41LDpIDp1hK2R
	OMr63Pxb/4/UxB9m46JEVHC80yhS/W3ydia8ZZ3osJAgc7HrWYpg7nmNYWljNtmId53DLXYKMeb
	0qHy4B5g3mjagCCYLkdPmso4uGe/tEb8pUEeSaMELmeYPnYquY3Bwo5XaPN66SBXDgxdAmB4kHb
	hE40PY8N/aBPIICLsFlXRnaprcSPRIy8xcoUCm2vqs7IM+Cm95/sndkpcHf3yiWIddC9yH+MCpu
	n6Y6Jq6nJmjkDWgKVatK4wS1OS46Zh24qiYgwZRFkNo1qqTF4eFAa2w4P6w==
X-Received: by 2002:a05:6000:188e:b0:431:a38:c2f9 with SMTP id ffacd0b85a97d-4310a38c454mr320330f8f.63.1765895236270;
        Tue, 16 Dec 2025 06:27:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+ix4WzDep1rU/6+82Brj6lVB7AwDo2uS3uSX9AUtyHY1SENwAUhiUGkaJJ72DpisXXC83nw==
X-Received: by 2002:a05:6000:188e:b0:431:a38:c2f9 with SMTP id ffacd0b85a97d-4310a38c454mr320295f8f.63.1765895235805;
        Tue, 16 Dec 2025 06:27:15 -0800 (PST)
Received: from air.bos2.lab (IGLD-80-230-108-89.inter.net.il. [80.230.108.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f38d01d6sm21017928f8f.8.2025.12.16.06.27.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Dec 2025 06:27:15 -0800 (PST)
From: Vitaly Grinberg <vgrinber@redhat.com>
To: grzegorz.nitka@intel.com
Cc: aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	arkadiusz.kubalewski@intel.com,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	przemyslaw.kitszel@intel.com
Subject: Re:[Intel-wired-lan] [PATCH v5 iwl-next] ice: add support for unmanaged DPLL on E830 NIC
Date: Tue, 16 Dec 2025 16:27:08 +0200
Message-ID: <20251216142708.14727-1-vgrinber@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20251120105208.2291441-1-grzegorz.nitka@intel.com>
References: <20251120105208.2291441-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Will a notification be provided when the lock is re-acquired?

Another concern is the absence of periodical pin notifications. With the E810, users received the active pin notifications every 1 second. However, the unmanaged DPLL appears to lack this functionality. User implementations currently rely on these periodical notifications to derive the overall clock state, metrics and events from the phase offset. It seems that unmanaged DPLL users will be forced to support two distinct types of DPLLs: one that sends periodical pin notifications and one that does not. Crucially, this difference does not appear to be reflected in the device capabilities, meaning users cannot know in advance whether to expect these notifications.


