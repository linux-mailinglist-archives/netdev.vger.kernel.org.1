Return-Path: <netdev+bounces-89849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1338E8ABE62
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 03:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95CA5B20EE5
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 01:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6339220EB;
	Sun, 21 Apr 2024 01:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtNz8W70"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051AB1FA4
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713664721; cv=none; b=WjU08bYclCOmkXo/iqqW4AZrxfPhGtRYu31sH0x6h6o6Nd2DXdjki4L29UCfW83oiO3kJEj9kd6cziSilM9U0hHnK6qKSorHWOUP5jbfU5pf2ixRwo1peBMscJ1cODICJ4OaNfo01QZhI70WFhBTkOYFxXdQHXBnxQzhnCJKOKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713664721; c=relaxed/simple;
	bh=IWZJu1hGsAeeBjTP3I6np9ZsDNKvKcr9juIWSJGnB5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqfYmmuJxKwqSPnW474A4Ra3JvHA6YsAor/f0Aal61IzKD1qfht34QWDOogzjTPb8oqAXLXYVuVBMKTkOLpGhTDoapJezS78M4elEXCHShHNK0gg8GWZq7/NisRHaMOSAgycOM7uWm9EzsYRyiqN/zFTaeRV6C+PE0Ea0BTWg6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtNz8W70; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36a0f64f5e0so14229675ab.3
        for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 18:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713664719; x=1714269519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSC9Pwb2TM2Ue4SP/owZwZxhzria71bLVtBzAgnDwdU=;
        b=CtNz8W702AssBhm2I9ck8v0zCtGHti4tn0ETuyT0SCzCqOM2H6UlA2HK778N4J6Pa+
         d+7CfrpU+dSQ6Zi4YkkEPxjRd6nX9LsHnLbedJMdgKd8bLDPB6u9yNuMHrnVT4k44Hop
         NPFlT/1Gow+5hucINR1DTyzNniEwW4hqjoSz1qRjZGH5hCtW22tFCxZb27Hspl3zbKdo
         ahPyWzxrjhglqLL2GlXGBksyLwJPimPCytfajrqb69OHmmS+mAJNmb7vsyCjHoYgvvsU
         N+QyX8jbBci80WwJjnuMY4UiZJ5nzzsesiQSPl0fHeQSlz/H/idQMtZVMbJDYZmKspLF
         TY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713664719; x=1714269519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSC9Pwb2TM2Ue4SP/owZwZxhzria71bLVtBzAgnDwdU=;
        b=dUJ1zJGMXedBPqJkPw4+EwDWOlFWYZBLaM5naq626ueg4vDak9dWfwAFpK4ixVj9ha
         DDvT/pioib0TrfNT0A2wWFzCyNxY2qXZ2Ey1Fm08yunqspcQBUyUYN++T3wJlyaA27bc
         IyCWnbta0Ff7Fe9RmYJ4W7roamUhZjCodZK8uQvpRjEjN42SX3dEj6h+RQsn4G3lftgK
         Qa2OeEHs5+5koo+tyX9gk18imChtLwRf9TCjT+o0/Q4BDyTUGz6tDvP4454SlLR8sW8u
         kiE3xZ699RxOY6MgvZHZCK0d5MPiP3tKHaeiNCgXcnOdDj1ZrCci/TK24WzRoCpbKk/K
         uDLw==
X-Forwarded-Encrypted: i=1; AJvYcCWvD0leNfqk2hxK3QSc9qeUDreKZqDHnoyAo+UW/9ZB6aiHjgjLg0FzkgkzwUmXQfh9su8lnDCUKICNYFLqSuUcw7wCOsIa
X-Gm-Message-State: AOJu0YzRVlkCAuxsVJFfoJ6yMTMbLvvzOYx5JlbgXYIi3S+E71GP8lQB
	RTfU393kRyawu6+BwRQP/NYtkZTOjFy/nMazP0e2YMBhqRjkmSXY9Og5AA==
X-Google-Smtp-Source: AGHT+IFPfs5N3HXsGkb99Ak/Y4fAJVaSfW6uDCPPO+LZ1DssfzpOwypBhZVtelaujTMaPaNN/4IaFg==
X-Received: by 2002:a05:6e02:12c4:b0:36b:1868:fa44 with SMTP id i4-20020a056e0212c400b0036b1868fa44mr8800075ilm.14.1713664719124;
        Sat, 20 Apr 2024 18:58:39 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:1518:4e26:8dc5:c7f9? ([2601:282:1e82:2350:1518:4e26:8dc5:c7f9])
        by smtp.googlemail.com with ESMTPSA id i18-20020a92c952000000b0036b2f00a989sm1451100ilq.52.2024.04.20.18.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 18:58:38 -0700 (PDT)
Message-ID: <579c2160-68c1-4d17-b751-508c9a5b5ab6@gmail.com>
Date: Sat, 20 Apr 2024 19:58:38 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ip: Exit exec in child process if setup fails
Content-Language: en-US
To: Yedaya <yedaya.ka@gmail.com>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
References: <20240324163436.23276-1-yedaya.ka@gmail.com>
 <ZiF/rppvSxED2W8m@abode>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <ZiF/rppvSxED2W8m@abode>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/24 2:16 PM, Yedaya wrote:
> Ping - in case you missed this
> 

please re-send; I think it fell through the cracks.


