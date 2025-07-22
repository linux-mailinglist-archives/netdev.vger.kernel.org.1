Return-Path: <netdev+bounces-209137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA1BB0E73F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 01:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BB81C282E6
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 23:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9F2288C06;
	Tue, 22 Jul 2025 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKBj8GqF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE7415530C
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 23:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753227463; cv=none; b=PojCbdDrHEEbKUrZpLS5opEqn5Yd4gfUN5A2D2/eAKHBf5UyyylUacp1z6bLsLm/QeRqKEpUjb3pAI8xtb+eoMMkwQKGUEPMRMZ2/l5jOTw0jKbUiH4R3984bHicpjYoaPiDBAEQCRevqg6QqtHRs50EmNitsdnMdbgac0PlRh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753227463; c=relaxed/simple;
	bh=F07gFZVWKsj2gBq61fu84n8sCkl0/xsNj0/pMpp0b/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UizzHhfuHPk0NZMf4JLCHw9c5n11URBBBHYQpROj2Elprs4bm9H2Y4j+dBuellSI9HeAtTQKFKs7lllKkA220nYllu34YmqR3jAXRk4gM3gv6vkqL2Q4cLqac5Chve43vVJByKipSHOzcnbCdkfpU2dG+Hcf0V4WvwaHyJ00sC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKBj8GqF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234d3261631so49655515ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753227461; x=1753832261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nPLikWH4LzOFBLhDxqFmidycRs+ic2dS9gVFgYZEEhI=;
        b=IKBj8GqFDEeZIpqKAo6dKu6+TcpsSMW+v2N8YFqi0VEbofpmx0MQwIrmFtOJGmLfb4
         +3f6RPu4C7u6kSL2bFNtM7zrr8ke9KxjlevlGNo6pYNmXqNlRC1YV5KjnXq6FCVo/cE5
         uHg7QlPyBMp+m97yvc1PWf0sbjUiWYkc0f73gEHl3YLDy3XY6grXPLaEuTIf70+aa5cN
         effhBTm3yU226Gwd21DplUBn0kxbHc8XxtwyQJBs6/JF3JN6uT5kPReWOTjoMTfObd5R
         osKt4o6s6NuXAKl9cHFzTxVLIyeODxao6Vg7CH3ZmEMKW8zM7YAKN7NTVpJg/fWOanvn
         0Kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753227461; x=1753832261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPLikWH4LzOFBLhDxqFmidycRs+ic2dS9gVFgYZEEhI=;
        b=W8dywz+5v6wBgKpxPF2GewD+XHopsmXURJDDx+76JUeFKllTPHlnvIDqpx7q9ahhyI
         Iy5Sx8AtIqw2SMIBsx4T7DS6T+Na5VeTDHrya6ucmX3rwdT4fOAKRu0q0febqkYX/PKE
         p030rQmx9vSlsnIKYOLOinD1Zjzfoe7DPaMlH0zB0f0fdNMfiuatA8x3MLskWR7NajJr
         VEL/uf1kh9qxCfjfpeLFMuZ1uUNn27gEi/fcWXN0tJ4kEBwZBus+DcybTyMlIFDU0STo
         CBqP6wj9nK3LlrDsMbxDCno8qUepQDfhDkEW+S8ITWI4Vn51uLnGRRxPVkTMEDHLNw4i
         fl6w==
X-Forwarded-Encrypted: i=1; AJvYcCUf3gJFX8rQBLVJInERgZWM7DGZFDTtz598KuCSttTTVOMsUYogA3oTK7PK/z/k9c91C9DzNco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvnipd9abqxOPjL0mSyMmbfqiC1epKNLDqavM7D0lvxiGE+3DU
	KgY40jMrqkFAPUu1VOrzlmDkLD8uP57tHDCDrrZpaFOW/SlqWGrDUuk=
X-Gm-Gg: ASbGncuOfK0Y4KzbbhXTVDOjFy+0fiPP5SrF0SGqJidU4RXqz6uHUm8UQuVIgCkJKuw
	YWocGJaKrO6XswIPW/4z1pGZE9Xc8tWwC2mS3GJ4x0ZdEloyvdDal4vvaV9rAKZCDvgUvtxKsfr
	w8hYn/+jpziOWINeMcjicq5gDpDyXcklp7vV3H6wBqJ7KvNwS+fc45QQBLtiGXHq7XgnvP7bnwl
	A2P+vYz/N22pG6sPvnvNnP0r4oGv0EM9Vz2nSWJ1dV1uXkm9IudkEqOehN/o+UuKMSZtgf6eAzp
	juvNuJw+gnKZguJli1e9yqMTXlIP71yq7KOzTNwnH9MqSXKrvk7jsw9L/retOXWNL15ST4MBw74
	J5otummvx02+O1ePdBwoIUcVXTHpJaQ+9DzCbMWXc3JHxRLJrJq/c828Up2ngVGmJpKU3gw==
X-Google-Smtp-Source: AGHT+IGCU+/COKVE+6WNIrdRuyv8nWYf3WK1AGiN6WlKrZa1ei5F0F8QJgoCmN/22gSdQg41Ue/c1A==
X-Received: by 2002:a17:902:e545:b0:234:909b:3da9 with SMTP id d9443c01a7336-23f98203afemr10490445ad.27.1753227460823;
        Tue, 22 Jul 2025 16:37:40 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23e3b5e3ca1sm84061715ad.40.2025.07.22.16.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 16:37:40 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:37:39 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, almasrymina@google.com, sdf@fomichev.me
Subject: Re: [PATCH net-next 0/5] tools: ynl-gen: print setters for multi-val
 attrs
Message-ID: <aIAgw3pgYGUUda4J@mini-arch>
References: <20250722161927.3489203-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722161927.3489203-1-kuba@kernel.org>

On 07/22, Jakub Kicinski wrote:
> ncdevmem seems to manually prepare the queue attributes. This is not
> ideal, YNL should be providing helpers for this. Make YNL output
> allocation and setter helpers for multi-val attrs.
> 
> Jakub Kicinski (5):
>   tools: ynl-gen: don't add suffix for pure types
>   tools: ynl-gen: move free printing to the print_type_full() helper
>   tools: ynl-gen: print alloc helper for multi-val attrs
>   tools: ynl-gen: print setters for multi-val attrs
>   selftests: drv-net: devmem: use new mattr ynl helpers

Nice improvement over manually doing _present.xxx = yyy!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

