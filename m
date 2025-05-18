Return-Path: <netdev+bounces-191507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D04ABBAEA
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A50188F545
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0902D27466D;
	Mon, 19 May 2025 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzL/gNjc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03B26E161
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649973; cv=none; b=niK8MHr5s4FmXtpSG+9Ke2sZGzxowsCJ8KxT9MSOAmFMkDcmmmls/bLlu+q+GwXeZGrKGtfZ0DcyIna80ORMneAUYpAgvvJ88IyywWCLYnrvTXd5ZP4/MdFEof12VVAkfAdkVIUlmGVVuZ7Mi2Rhcqol4tFtQoVn8gNqSlX2Q6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649973; c=relaxed/simple;
	bh=YRoeBibbE+BP46q+uwfQ5+0c+rRuFLfR0clW4RO41ZM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=mIegZeoMlrLC7oH0YLd4JynpOfeJ7esN8rNiWQNeTayAdtfOt6zlY45c2o3F5flR9q9pf2dLMxe9rZOxltGdmeZGd6X0G0vB+oL9nxLsXK0hv1Ac70NnA5lD0lxzkYEAEFqM5SPrc6M/YRK47Tl/sTSXwPXYd7doguBnfI0a8Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzL/gNjc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so29907965e9.3
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 03:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747649970; x=1748254770; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YRoeBibbE+BP46q+uwfQ5+0c+rRuFLfR0clW4RO41ZM=;
        b=WzL/gNjcD+FPg1eysX7j+wAL6sAZ151JiPVHCPXQ/Wtvdmw+kS7axvosbQgHU7ovfg
         Qycxr5okDFFlbrcDytTOCWxrYYi0A0na+Eel4vpkajssz3Nk4yRSnobgZg27WmzAr9EN
         YMmz3fLrOypaXOIXJD5/8ATFJEgrg7Zam8jID3WNGT7jNLpthdbT1PvUxOqLKHHNdN2Y
         4qo8t5mTca+bEUPrPJKKxR6a2THxArdm8EZ2QCsED3ovTXXs++I/mb04u3+qSsdYyoL4
         3EklIerQqOu7ME3Q3TJUvPJ4V2B+YLM2uTJWuAULSVta0wnslpp0SodKAlKllmzD8gQ9
         OgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747649970; x=1748254770;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRoeBibbE+BP46q+uwfQ5+0c+rRuFLfR0clW4RO41ZM=;
        b=XeFrHJs/ne6RoOWkch7KFYrWZjCCfR7Lxv44l3TPdPLVNDsnhsbIT0bEAz0OtdzSMf
         tWA9hQnmYw9p/OixpOr0AzOzXMmCMtgHkCyrHgEktrp7TjYiWHT964lCrlfZBB4Nwv20
         6qU+kMeNMVOj8SxVcgCxFQOlReGr/OJ094t6SvXX8rGmA/Fy1ATSYwpFSz8aqWPLHYS1
         5lIKSMI5s5z6NbrVqg0EQR9DMG/jU56pIqLaOxNUt/xyBEHYMin9axfgP3h6lV1+zdI2
         k0VtwEz9IpoZUIhJqo0wCc3g51BWkmWIYZuEdrE/zPoWzmALT0czs48hDFCIwel2FOLY
         +HIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHRWYljD16MU3zi+gAsfjsItRTuIIbg1BpDAtTJuC0IEbt/qAQUMl5E0voRx+KQZ6Mq9Ex1Os=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoWgceN4GeuAPYwr+eTgo2PjL1Vg6tB8yN2KehCwQEAtDjcwx4
	XQRYStWa1XIQw0+b8VZ66e0rzK9phTg5qmyEZfDdO0PQ4jdmZkVuLs+B
X-Gm-Gg: ASbGncsA7E+SDYB7GdYXvJDBhlB/eX/q2DZ9+jWunHmbSMJxQ6NBFOv7qoZBERG9HvI
	DH4zcE6FNIizINdKEiMWpnZvOzKxwsGaZT89TRSTWAvQu/B/sRINhV1oHS/wimCKVVPCbkSRUpj
	V206qNeBuksY3dTfFRJauqrQHmODLY68tU9OZAtI4v6YAt6Vybk0OYPLRByTANygbxgkgQRA/BI
	vk6Bj7nVt7stCH4kN6h4X1fBQm7Y1fAts9F3iauLfTaG5gnWg6c1ty9IeNuzhaA8dQyYhg9kC79
	20zEBvUpFDG9fngtx/IactBCScjE+Tqg1h2c2RanG8anYSC44qgxVe0mI3aFBAmk
X-Google-Smtp-Source: AGHT+IH8g/5kY0nWhIoZuWv7Rm4D/8Fq9kNahmacraHfv436vtUHLiL1qOQVpEvYdNp6rnjVRLrilQ==
X-Received: by 2002:a05:600c:c05:b0:43c:f689:dd with SMTP id 5b1f17b1804b1-442feffb593mr112190385e9.19.1747649970422;
        Mon, 19 May 2025 03:19:30 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:d5e9:e348:9b63:abf5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd51477dsm135988035e9.17.2025.05.19.03.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:19:29 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jstancek@redhat.com
Subject: Re: [PATCH net-next 06/11] tools: ynl-gen: move fixed header info
 from RenderInfo to Struct
In-Reply-To: <20250517001318.285800-7-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 16 May 2025 17:13:13 -0700")
Date: Sun, 18 May 2025 14:49:19 +0100
Message-ID: <m2o6vqjag0.fsf@gmail.com>
References: <20250517001318.285800-1-kuba@kernel.org>
	<20250517001318.285800-7-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> RenderInfo describes a request-response exchange. Struct describes
> a parsed attribute set. For ease of parsing sub-messages with
> fixed headers move fixed header info from RenderInfo to Struct.
> No functional changes.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

