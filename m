Return-Path: <netdev+bounces-191505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315C3ABBAE9
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF6A18873D3
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36410274677;
	Mon, 19 May 2025 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9YDH7iY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735A274640
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649971; cv=none; b=EfnmiPaKnUoHp554tje21OkgaH/A33IYU6+CmTkUHqmb7un+gL4d8o2EouPLQn/hd5VrOueCv/q2QL3SglftEzWPmbC2k9bL/jhdcT6nhR/9xpVsdHnAg5V8VX6A2s6DR9oBlfep04vnNnpU+C5HpvD6NkJSItuvnKNMW7zcud8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649971; c=relaxed/simple;
	bh=HiSCTcwPP64JOqQclMTtlvThN4Qtic7eXxGdC14SBRA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=IRwrH4OlAyp/McrgqugZ97DBnU1I3s4m/wjYzIRlT81MswOMz/9q9PDVA36ymRWprFWscbmaty7/9tRMet/pvj+q9sxmm7cRTBPrIcJ1EVoMgEJXrhUkcXxhYbCGGSz40SEmIrTsD27nSedCThy9AatJgbYbGe4DAsc8gRYZSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9YDH7iY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf848528aso36850965e9.2
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 03:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747649968; x=1748254768; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HiSCTcwPP64JOqQclMTtlvThN4Qtic7eXxGdC14SBRA=;
        b=N9YDH7iYRO4txlINn4FcbD1oQenQWa143c//i4KecdFzN91h9QDTvWtFrnixxLzTlU
         ulZ6NXSL2sD7Sy+/ZtDcp98CnjGLYOlsyg97D+4S1k57lstg4zXBoOasWaQ/WAJcax3b
         r4ngRGIF7x7puV7QxqJAYQP8B2X2kB38ZGleWDkqj7xNxV3JabOIPAitJ7kikIykGIvv
         16Vd+Iu3RmFZsk0Pq7DRYc3yggMBnocPNVoK7nbv6aoqKTgUnDQTwnf9LanckjMLBmOx
         zgeRkhVHOmuHLsdLaECHFJNDlY1ZV+fNq1mfTuOskMRNEhpuhVXYceIkwc9HhrHnlakJ
         7/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747649968; x=1748254768;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiSCTcwPP64JOqQclMTtlvThN4Qtic7eXxGdC14SBRA=;
        b=nRNlv5pzkZTh/wZ7Z5fY+ChlwmC8GAWOqxp4FZiYBEb693WhXLUluqCw+Oj56D4wzk
         mNZ+f119QhGbpjtVZ7gl2o3Ay7uF8cy5tRuNhRxVycU6tur/IXbOJhrHQEtXmtviKWI2
         5/z1AetsIPc1i1a4PKxWQj4UIyBCgs+95btMOYadioYMSQCkvX7t03JWPifI+aJDsBkO
         b1DIRi8h2bi/g/juB7A6S8d5mmipyW5DNCqDEnh3tk/XhL8c/We45A5H3xP6UIMDAt9/
         DRDeUvZkaeaAzFrRBw3q2bzl38y4woJVjF6Xag5lD7USW8Z6djM4K2GelS/TyjdXdRks
         SgQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXajez25jDYDUtk5FIgCP4rrHlfBfNcIbZycUCQfSgFFaXQRMYl+NgatN7a/S2IlyEPaBnR3X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKdEPv78Nr0yPDxOnq3JuigXEOWPuSs4vihsPIpJxcLvHRzBd2
	GNhFhE7zjGE7Jw6u0ey7Gi+a0x0vgsc7BOXOBDq5DdvIAnT7CIAF5ylg
X-Gm-Gg: ASbGnctZjCLWVZtNX6yfOtfH5D9YMUPUCi5P/k8HvO7Ap6+oSjuBcgCDxZ+37ysoryR
	5ZZjL34gfE1fSByGfWnzPluVf2kjAZzC2nLl35SKFO/DvYGKMCA00XdlTw7ieb2vVEvNQD70gOD
	FM4VqgdiBnbdlA8lkcwruQiyLZjg5+eS9mf+cQVFz1z1WaXUXfXhTjLXPVuvZuApWqFLKk0kRX/
	nFW8Ms/oQwNsL23ZrJndmSYU9WhNAh10KD8JTyolqHxmXi7KbR+jeU8KIe1eBmoQgaT387Dh6Nf
	I2471XQAL5BCF366iJvYLYcEhxmsGb/8cWAoTidOwKbInXUXEagwsLxzL+fEeIrQ
X-Google-Smtp-Source: AGHT+IEcypKu+vPetiIHeT8IanVivY6U5QlOaSHgZ9nflErXG3W8htS28x2qQuFw0BRyOcGHlLZ6lQ==
X-Received: by 2002:a05:600c:a00b:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-442fd6313d2mr130485505e9.17.1747649967543;
        Mon, 19 May 2025 03:19:27 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:d5e9:e348:9b63:abf5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39ef8f7sm200773665e9.39.2025.05.19.03.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:19:27 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jstancek@redhat.com
Subject: Re: [PATCH net-next 04/11] netlink: specs: tc: drop the family name
 prefix from attrs
In-Reply-To: <20250517001318.285800-5-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 16 May 2025 17:13:11 -0700")
Date: Sun, 18 May 2025 14:37:16 +0100
Message-ID: <m2wmaejb03.fsf@gmail.com>
References: <20250517001318.285800-1-kuba@kernel.org>
	<20250517001318.285800-5-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> All attribute sets and messages are prefixed with tc-.
> The C codegen also adds the family name to all structs.
> We end up with names like struct tc_tc_act_attrs.
> Remove the tc- prefixes to shorten the names.
> This should not impact Python as the attr set names
> are never exposed to user, they are only used to refer
> to things internally, in the encoder / decoder.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

