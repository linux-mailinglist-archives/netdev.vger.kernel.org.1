Return-Path: <netdev+bounces-191506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0339BABBAEB
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7AB7A50A4
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF332749E4;
	Mon, 19 May 2025 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXeZAp3o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D327466D
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649972; cv=none; b=canaN21Wp3q4jBVQ8ShFdROFaMzh1+t7Q32pW4iUzlH0AlakV8F9qG2OSHpE1iMxHE2i3ZtKAZlIe5Ow9dBk+jteNrD4CIRTTIUD5tmk+VPfqT2iWXv2/gFiMnqbNT8P6+xiSnUdViNPfhWRV7B98UUcMVvgK8M0FcW77GHCzwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649972; c=relaxed/simple;
	bh=VlsFr+7+d4thW0ENvyWCL/TG8q5YYdWp0aDQKMXJlJE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=AP6SJI9N+rJ1GiGNYgc1N0hEBxzOkQrT0P7iUKZI7v9FCiyi09NO48b8l1hBqxwvrPMdkrCQKOZ+SsdijtfcWv4j860Lok+jZHAafM+zd94DMT6ca7wl/F2l/xH/ntmsX/062XulP8owchobMLVmMbR+69dGDVjAQLJE5NY7N2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXeZAp3o; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so33588895e9.0
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 03:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747649969; x=1748254769; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VlsFr+7+d4thW0ENvyWCL/TG8q5YYdWp0aDQKMXJlJE=;
        b=hXeZAp3oTORzA4KRpmFfJ/+2tM4QovOZ0k1GCtdElMcvFuWqCtQV0oY/frgE6Wko+q
         ZLQWwzLnRgQXaTSjzbyrIFMnLvM1HNKTzUNYdjMbSCWIAHOrkEX4ysEaKWVsN3uISl0Y
         GZYGldwHuJIGlb/BYGozpIU7Q65c9mo/p7MUIKK7Q3Jsv6va89TyZwjyWUHCY7AK05JV
         qudJlGKXDj3f6wya5CBWC+3V/9NBv0aPpdZlXDjI0MrHkU9MoT+2cYzWKM0kBxY+CEm/
         tmFHDX95aXXHqZo7IuDLb07UZCYBG3GW+lDDfjfosGjENNBX6nRNO/dQRmeMW0guMFKy
         6n9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747649969; x=1748254769;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlsFr+7+d4thW0ENvyWCL/TG8q5YYdWp0aDQKMXJlJE=;
        b=vL0qib7n1rB9X9Teew/wRozQ67ZXd9ZYogrtp/6LE4tlLKlzT2QAsns2ajiP4QhoHt
         QVseN+spaspJXSIgXtkD7QL1y0umX/XB306ta6Up3UP3LSgGnTqEHcCsJlZz/CpdkI/a
         PdiH/0SPSz87OSsS5+5p1gEZqVb03o3WZkilAGfQDCmXgP01zXf3pZq5CvKA1x5fS7EW
         dfJmKM8nhAtUq6VQZ5vlWWVO7N2mfjifwf60XZigYRPuyrKtFqJAAGfRS3fKGDiiAKkP
         QEssdSQqFve6JEhG+60X695DTlkF6sq0kLqznf3DcHKDg/uM98xDgysGIiw39txAGOXx
         fsrg==
X-Forwarded-Encrypted: i=1; AJvYcCWxYTdanV+10v+46xvBNcvuoxzYOI0g8dj8VCm8DVtJ6g32paGrn77E8rc68TtLpIE7vyA9WHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsc94pEBpJL0PDap4xvdcKv+SfXm7112czvxMDmPDSGN8vm7S8
	rXmc9XLywmjYsn+HM4XnYy3oZV5FJr+ts3ME+/ZOiHaL107NPGLJL/iA
X-Gm-Gg: ASbGncswp10TIDWr6SJ+EZLAyv2zFvJbU/UN0Yeye9S9XaF4m/dJPTgh7jEJ23JVFRk
	azXCwrGGb8s9Nl8ZPjVAcYsXs95j+DHgEoTN3X5EREwqDjbRPckUR5VV3LKkrg6DFpLtto1japl
	QJb7cV2DW7gJ7OfshYOtFju6w7aH2YWNFInnwLgWeyXfm0HzfgUhi8SfagQAExIBk0jS5ArtvLZ
	9t2hcXZodsO8tnnazlztPacgPorTZvyGMhRYKQyz5hCIR+ezJhvWmWWChRW3htdc+Xp9Q7gDJ/F
	dFL7SX/Gi7MgCr2dak/NGH6YosaPqF7i02wZLgmHAiGR6fBw7rZDE4Lm+SYG+kfi
X-Google-Smtp-Source: AGHT+IHqaEkIDCSXBgISI9qpSVdsgCXD1koadtbxiLU3P4wiHUBDpxJIFfUNFSEPiJsPs30Aud+rjg==
X-Received: by 2002:a05:600c:3ba1:b0:43d:b3:f95 with SMTP id 5b1f17b1804b1-442ff03c1f7mr83927095e9.28.1747649968920;
        Mon, 19 May 2025 03:19:28 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:d5e9:e348:9b63:abf5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f6f9b309sm182939205e9.30.2025.05.19.03.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:19:28 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jstancek@redhat.com
Subject: Re: [PATCH net-next 05/11] tools: ynl-gen: support passing selector
 to a nest
In-Reply-To: <20250517001318.285800-6-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 16 May 2025 17:13:12 -0700")
Date: Sun, 18 May 2025 14:46:51 +0100
Message-ID: <m2sel2jak4.fsf@gmail.com>
References: <20250517001318.285800-1-kuba@kernel.org>
	<20250517001318.285800-6-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> In rtnetlink all submessages had the selector at the same level
> of nesting as the submessage. We could refer to the relevant
> attribute from the current struct. In TC, stats are one level
> of nesting deeper than "kind". Teach the code-gen about structs
> which need to be passed a selector by the caller for parsing.
>
> Because structs are "topologically sorted" one pass of propagating
> the selectors down is enough.
>
> For generating netlink message we depend on the presence bits
> so no selector passing needed there.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

