Return-Path: <netdev+bounces-150447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9161F9EA434
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2322A288C99
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 01:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CAA45009;
	Tue, 10 Dec 2024 01:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1pzSTXy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906123F9FB
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 01:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733793666; cv=none; b=nsuovmQoDvQrrgptjq1V87WcoVPRVqR8UDqpmhTkPXPjvy9Fnml+BSctZpNOj36krTiDJE6OzQ0NBfneNEQz/NezlgVvmxGcvk1uv20zAMHT5go8Nj6/g4ojEk++eq27eLVTwa1V+nkDfNGTsEzEKbDqvTCZW0Hng9ffxlwVG1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733793666; c=relaxed/simple;
	bh=vesQ/aBefpzwM/hUikPTPoN68yekxnj5zT4caGuaOnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdtlylwCzLOwXbvst3lKRL4ojdatk0Wa9Qqgq9a+zT0e5z7ka7mLCnVDviMBAnrxy6MnVkIjfRAzLZGgCtByu6KPFRf/8mq2LUqX5SQ1QEnxvANcj/m+cgSiysMkjwPx+2W67Xgg+ItdKTuPXuGDFxXrxCylefIyTawHVYiWWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1pzSTXy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7259d6ae0c8so4206657b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 17:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733793664; x=1734398464; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zyuQUjPZZvNEDH/8Sc7mk+rdFAAmGwA057khPHfzgaQ=;
        b=R1pzSTXyzST+oqSCXZKqvxmQK/gL4/kLWHtUJxIE2C5Z62hUtbL47trGATyH7FkmS9
         oDIuNUdeBY8rswwsAljyv8ybQ/40GTU53nfLThPlvIZ1BlXpkRDSmqoQ0nGZ10DfR+GD
         KyGkWzSkTXk4kpMrKCAWjEPdWnXzwwbwqS/X/++QQQe/PXATXf7Z8pxFcuOfdmRWgUsI
         lGIDrQbpfjF718ODwD5mwnKo0iYQSri2fBEA1ZpDuP6uT7KoZk63VM+Su4imeJ/temrN
         YAXPT6iPBys0jbJepe3NqQQtt/Ctk0xXf22veznOywPCZCIK+c42aiy1fP7PM6sbp6Fp
         lrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733793664; x=1734398464;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyuQUjPZZvNEDH/8Sc7mk+rdFAAmGwA057khPHfzgaQ=;
        b=GM/BauH55x64W6QGZLsZebj2gp/Sm/+m6FmpFKxToU7kDeIP6suC/ntKCpVfByM7CG
         kac+ReLnkhgfxEWx0XthXLx3sCuo1MdE4eyAyDtv6Z8eOh6TaH2Y99ojhoTXHTqYhp8r
         wR3AZkkBMF3/WZqppwbxDyUBV1TfZb1JGT1DUcmkEr31Ubg8l2/vE5CUJ60x1//FZpBA
         fJmX63iY1jqVetAj+WMIKr1tX4YjU0HKmhmiEbu5WSExmD2Zf0Trr5SosYKi/BVVI20J
         +5poOh9QoED+l4NOdFPKc87BTN/pNuvx4qG3Anvbia6r0fPLf3NvzbJoyXeSvB+V1yij
         FqKA==
X-Forwarded-Encrypted: i=1; AJvYcCW1zQhfs2sR6PjmMotvPRB0wu5unGrIlAaP63BUzualm3VYNS3IA5IA7sN8j1oi+5mmo4waHLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5xtHpqJBY1LP6xCEmgUFRO6RJm6QEFq3qGnNhP3fxSZNeMiF
	782uiPfetTnKVN2csiTvZsMrvknatjJVEbjPCkTmfYSTd9Yi3EqE
X-Gm-Gg: ASbGncsjU/2ewie1zPx5JRUVuGF1bJffgdpa4jzDz++pNy80Y6BcH9UnMQ7NU9vfmJP
	/zmyMJRVMP2yb4sKGZTXQgcUiQp75V2jsdZjTQCGQZOAjDUSeBNJUFliGHA9HQ9afAo2pJF2odc
	toLLC1mkeOEGqnfXNdwi5bY02WdCPCO4MaO4lgpqtnHYpYD8e1j+dWn/ls4wJtVcTlnbVgTwdES
	kH+6JY0obiByU3rdVIoT19amyfRd1Lbw5Rnnk+0Bl75kH6KwbScDgFvxn4=
X-Google-Smtp-Source: AGHT+IHhzzY4LekEFccBS5yoKlbpaKuUQ+UVBLuslM2IeTHQe/MVAoOgAXL6YKsn8JbOhozNj5wVpw==
X-Received: by 2002:a05:6a20:3945:b0:1e1:aef4:9ce8 with SMTP id adf61e73a8af0-1e1aef49eb3mr5724823637.28.1733793663699;
        Mon, 09 Dec 2024 17:21:03 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f13cd969sm2121465b3a.6.2024.12.09.17.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:21:03 -0800 (PST)
Date: Tue, 10 Dec 2024 01:20:55 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	roopa@cumulusnetworks.com, jiri@resnulli.us,
	stephen@networkplumber.org, jimictw@google.com, prohr@google.com,
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Ruddy <pruddy@vyatta.att-mail.com>
Subject: Re: [PATCH net-next, v5] netlink: add IGMP/MLD join/leave
 notifications
Message-ID: <Z1eXd2HROVbFM6mt@fedora>
References: <20241206041025.37231-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206041025.37231-1-yuyanghuang@google.com>

On Fri, Dec 06, 2024 at 01:10:25PM +0900, Yuyang Huang wrote:
> This change introduces netlink notifications for multicast address
> changes. The following features are included:
> * Addition and deletion of multicast addresses are reported using
>   RTM_NEWMULTICAST and RTM_DELMULTICAST messages with AF_INET and
>   AF_INET6.
> * Two new notification groups: RTNLGRP_IPV4_MCADDR and
>   RTNLGRP_IPV6_MCADDR are introduced for receiving these events.
> 
> This change allows user space applications (e.g., ip monitor) to
> efficiently track multicast group memberships by listening for netlink
> events. Previously, applications relied on inefficient polling of
> procfs, introducing delays. With netlink notifications, applications
> receive realtime updates on multicast group membership changes,
> enabling more precise metrics collection and system monitoring. 
> 
> This change also unlocks the potential for implementing a wide range
> of sophisticated multicast related features in user space by allowing
> applications to combine kernel provided multicast address information
> with user space data and communicate decisions back to the kernel for
> more fine grained control. This mechanism can be used for various
> purposes, including multicast filtering, IGMP/MLD offload, and
> IGMP/MLD snooping.
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Co-developed-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> Signed-off-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> Link: https://lore.kernel.org/r/20180906091056.21109-1-pruddy@vyatta.att-mail.com
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> ---

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

