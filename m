Return-Path: <netdev+bounces-244949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44613CC3C4A
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 15:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EB773184AFC
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 14:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5D733D6F2;
	Tue, 16 Dec 2025 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLhWudYE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsIX3RdC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6771A33D6E5
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765896122; cv=none; b=g3lc28aOIlTJ+fUs3TLrvzdp4lzKUa3ZxOQYwxJA3RSlldmXENhFb5B8wLMr0TPnytTnS3AEiyDwknKGLjNIiNnXoavKUSccxFjIfXaiv/WMDBKqiCNrC4pT0CduDMg9l07CDHfGdIctA+Elhmd6FY7uQYvAm5UQiwvpiF2gxZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765896122; c=relaxed/simple;
	bh=bRJifwBpOn5/UKOhHLvWKxzpriP409m/28t9c1F6o0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJ9XKvSGH7y3hFnG8B9aVGZuS7ZjTBKg81i/A2SuIem++TBDl/zOBYGkvnHqvokzA2TGUH+8MMouiwYqA6LYSiEETMA0nTF4OJzdPW4o2yPMrwXRBbOps3O6pE5fvippP1Ie+sC5fN77og0B5Cz9i3Ljvh++FriJ0EeITkEUIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLhWudYE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WsIX3RdC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765896119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRJifwBpOn5/UKOhHLvWKxzpriP409m/28t9c1F6o0w=;
	b=GLhWudYELxR7Dxqs422+Xf3v4E2Hik68hkLxsLEYYlF9e5Ny3yD+RtmMfrL3boZw9Fq/sT
	OwP1XF6mSH/534en/VMtCyKJ73pOYbAraw2FUoVU9taqxXhokGU3JbxWOCaYfArOxMJwUA
	/f3cokAkAaq6kTgSLAuwNoMywaYesNo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-mt8tXRH9OW2fjffgT8zbHA-1; Tue, 16 Dec 2025 09:41:58 -0500
X-MC-Unique: mt8tXRH9OW2fjffgT8zbHA-1
X-Mimecast-MFC-AGG-ID: mt8tXRH9OW2fjffgT8zbHA_1765896117
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477563a0c75so30707155e9.1
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 06:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765896117; x=1766500917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRJifwBpOn5/UKOhHLvWKxzpriP409m/28t9c1F6o0w=;
        b=WsIX3RdCZ+46s66Vf9dwj+aBeZbWVqhSD21mQ5MQQnEatqkFcLfwRFqQ4xPtiw636D
         8A2zm/Km9Ug/EWLT8fFbg+GFIbgCrpQXipAPak+R69/tkj6yBitEotb5Yd8OyH8/w+uV
         nDk01QmvS2f9d/kUEvzGdQqdkJu15FfYCyJiPLAZLIk/OkCTGNE2YvUR6YIBfAt65Gml
         GuWTLAxtgsGvb7Jo6fNyF1sSqFn2Bs38hBVwmGA7VmcHvm76xExapYPHzz+O1h1oM1/B
         5RLrsJbOqIjPIj7Ys0ySF11J6B0L/M2+8iCxe5dLDfoo1M+jLTC7jY0KJVaw4I2tk/vw
         ATTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765896117; x=1766500917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bRJifwBpOn5/UKOhHLvWKxzpriP409m/28t9c1F6o0w=;
        b=E/nEKLokO/WdJRvSr2Y8CFFzI/7uuiT753mL9w0B1W+Z6K/gZrvSsVY0BJXczNlJYx
         /wbFg/IjrfIySgpCBZjPBjT9td1YSHz1hSBBf3H8O08Nco9KFNCTue2GkNfxWAixS/tF
         DpEtMoEiI0+U9hY0CqVJrcEL+8HmlVQ3VUfX0RRpk1VuSYHLQDFvmAtSLgfOOnpJB7a7
         RO1w8Lr18TzcrNdWOYCyHV9Pl/PuXo0eiOWYUJavOyjWJcsfN+mBnfguqhFPM97U6oCt
         RJAESuOO+9pBGYDP+kpcLDDUHAChVl5+0jTkIVj4FlQa+CqUa3NGSNNwQduXWr0rRJyI
         +VHw==
X-Forwarded-Encrypted: i=1; AJvYcCVkKDupJEs2l26RNaPC58wPHgRhRrqbaEcNHea+yxECAE1rIzNjAQBaA4WUtV6kFlO0EUCgW2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy49FOaQ8OQHr2ltHU5b5xw0N+Bt9Dy/yiTsIhxER91YrGN2ZM
	nR/3BywTeNuot0ZGhq1tLIetTCDtoiRi/Xwh4Xm7WlJ9NRKCruNQqWYegfjQli1kgMjZH1AYO5H
	Yqkk3o6DJF5ZZpx5HdZzSQtf0pUiZg5reaDkum1/0sFZyn1rk18Rx2ZJGnA==
X-Gm-Gg: AY/fxX7R1IBQTmvr/AHIBGev/a6SbkWKLwtQl99mrzhBHS48gFWkY5fGUNT8GjJ+CZi
	aCCAqXBTyrkzX54kS20wSapaIwATZv1X4WHR+GYWl0KcPeODBlEXPQS/i1VakyyRtijt6Mc/Ehw
	WCswgMmSNFBN3h+hvG4p5oZsr5wyGe1SysXdoEjmhKM6p97Q69TvAGgylmVqjB03b2Ue0Dit7LT
	ATgJXbN4A6B4It+W9Fn4dCBycybfYk/ys63F9NtyEZri6krFs8QfIbSVAL9LOFp2458YkF0RlQ5
	QLoTNMpASPoyiXdb/P0ktiXLFYgNAjT9ntTwH8t4aSlP8/G0wJ264x96f53OJwma3yM83nAiv9R
	Tlq34G3DHuyW4YeOy6c9sNp0PtO1PeYEYHWUDP7p53XUnR2/InfJSXZ2mEQ==
X-Received: by 2002:a05:600c:4e91:b0:477:641a:1402 with SMTP id 5b1f17b1804b1-47a8f8ab745mr153358965e9.4.1765896117026;
        Tue, 16 Dec 2025 06:41:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCHHUOLaChiULrMNPkPpFyOPs7hl3Y2G80tSl6Je//NwD5E5/AOJ5UHYUTERMFN0KxTwrq0A==
X-Received: by 2002:a05:600c:4e91:b0:477:641a:1402 with SMTP id 5b1f17b1804b1-47a8f8ab745mr153358715e9.4.1765896116595;
        Tue, 16 Dec 2025 06:41:56 -0800 (PST)
Received: from air.bos2.lab (IGLD-80-230-108-89.inter.net.il. [80.230.108.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fbc6e3392sm24205212f8f.13.2025.12.16.06.41.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Dec 2025 06:41:56 -0800 (PST)
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
Date: Tue, 16 Dec 2025 16:41:54 +0200
Message-ID: <20251216144154.15172-1-vgrinber@redhat.com>
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


