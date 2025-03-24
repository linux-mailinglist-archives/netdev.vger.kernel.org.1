Return-Path: <netdev+bounces-176999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A37B0A6D32C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 03:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5093ADA9F
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 02:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29354481DD;
	Mon, 24 Mar 2025 02:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5tV4NTH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B403E15E96;
	Mon, 24 Mar 2025 02:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742784679; cv=none; b=phpxcXBkHGCO8DTeOFSwl/BNCodAtS54DkQLXKj2BvuQor1MeqAc51Gud4g2icoZSTiIJNqhXfd4iMW9nwTCZUUOEdQEMIKxIZDcrr3f7YhZ3ML8Ff9JtxsPD1xTOMz4sanKWwn0pZB8b1MQYWZtlc+ZhfaCx+/MjXbti4gUiBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742784679; c=relaxed/simple;
	bh=62kVpsCPiVBMuYEGiSDN9hVgk+gVk08KZPVAsmEKjs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qem6qUIaoow6szwJwDbPri8jchA6ulPqD8mU1UqzxkCShCmWx2drF65oJa9z+IdgnxRN/gkLnuM+hFs2mY9ZVF5W84xQ4VbeMQoPwFWoO3S/ygAHguXdVG5N9HV2AHPeolxvrDp38fRv56w0ZgTGCV6ys5TZJ1c4yo2te9yFCXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5tV4NTH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223f4c06e9fso58977545ad.1;
        Sun, 23 Mar 2025 19:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742784677; x=1743389477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmOUsKVpodBsOyNVlOGtgY6HqUrSsTgb/uJ82SW+YH8=;
        b=e5tV4NTHgcoP8IvF00hrOKEyXkKBDs9P0vSq13oNkNkhchzBS02kkDj04tkJqvbTFU
         gvmCsO52bDLo1r652lrr3nlAYiqsr1VWMOR0NwYLUZYq9QVzillU3K04V9rth/1ENsvJ
         vqlFnl9GerVAkVXnJVnS3mi/55A9/VV+0MdAji0saoAT8gKzGvtT+gdQkfHaUPqw65t7
         PGrK+PpfBNm02lg0iFNw6UUDMc+UTp55mVxS6p6QpqYzKtPEQ0D85O2i2ufurML/IRgI
         UwmfBzGRAMePiptcquVqMe7C7ra+4BQ1vx5prMi+7qc3opWLiir9PXY8c40KrcqRJimJ
         Sxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742784677; x=1743389477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmOUsKVpodBsOyNVlOGtgY6HqUrSsTgb/uJ82SW+YH8=;
        b=kmtO8XFEhqKN4P5tVrhgdq5N03hXr96K2yUlEMsA/ZkNQILYksVv87mh5abkUXrqJS
         v8wpupgcv0FU9mckyRgKWj97H9jNRw0qVTyOJQ+XJGzA5CPnrDxbsBypmX9ZVNGcO9aI
         7xlKzD8XiXZPn8WWwoGplkID6iwzDxJ0h4UUq/3HXfFSrg8uu7QpeBeoHk9zRGNCMpka
         +s6NvJsR71ZdoVba1FMlNN4PVz8WOmnaWm3Ua4bAuga+Ta0RfCq+ysiQ7ZpXx0L5sX79
         46OVshsieDTT6Fx5HCqDIQUY9ueorVl03M/8FaFWH9VUgjCCoVZKYj8nlOqhZgzPrBt+
         ccXg==
X-Forwarded-Encrypted: i=1; AJvYcCUdroN4N4eek9aM2ALYOP8TFmEm4FEEH9MlgHv/c/N+FNyB8Bgz02PtN+YNejnY13aE9bShEygz/TKKjXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFExx1CjvUrjWIAq8GHzb7OQwhuIrZ2vxQ0sNtGAiBHHv4NurU
	iZPpZmUAzWm91G1BlM8s5EFEA0UE5i04jpGz6gzOfmF0EJjC8TU=
X-Gm-Gg: ASbGncs8TEvUZJNKJgyLpDT2QnYFm5nr0DArdKvCIbY5VRIrXa9JfmoALkhz3hl/QqE
	X04n23/kH8IPb0fNkWKLBfiGQ3LztXiALi0t6htZjvlCjc6NZuWoWA1nUWAVtOw+POPos8KMln3
	zvFkZX1U5sFJi3CuttIql7xpncHjKmnMmxzZtddktibO4Yrf6RWtMqG75ACAIAh+FmOU4mxVAOS
	pLoEOybBLLO35FFIYfhQrFR7EPWAanm48CCqINZmOkSQaq6Lrqf3ZXBLbvHb6xQBW4L3O6jICji
	taTcMDtlfZBmwB8RAztxEOg6fZ0IpCekivbjZCFdv+6U
X-Google-Smtp-Source: AGHT+IGGRgHuceW4Ja9WxeF2fxb5FGTitH16xnIMpUrdNEGOSm/NdoNPs4KVWjInvM5yDkauFv7/RQ==
X-Received: by 2002:a17:903:1663:b0:221:89e6:ccb6 with SMTP id d9443c01a7336-22780afd49cmr203755975ad.25.1742784676835;
        Sun, 23 Mar 2025 19:51:16 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811b2bc2sm59138145ad.118.2025.03.23.19.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 19:51:16 -0700 (PDT)
Date: Sun, 23 Mar 2025 19:51:15 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Kirill Tkhai <tkhai@ya.ru>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH NET-PREV 00/51] Kill rtnl_lock using fine-grained nd_lock
Message-ID: <Z-DIoyY_dGmNO6do@mini-arch>
References: <174265415457.356712.10472727127735290090.stgit@pro.pro>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174265415457.356712.10472727127735290090.stgit@pro.pro>

On 03/22, Kirill Tkhai wrote:
> Hi,
> 
> this patchset shows the way to completely remove rtnl lock and that
> this process can be done iteratively without any shocks. It implements
> the architecture of new fine-grained locking to use instead of rtnl,
> and iteratively converts many drivers to use it.
> 
> I mostly write this mostly a few years ago, more or less recently
> I rebased the patches on kernel around 6.11 (there should not
> be many conflicts on that version). Currenly I have no plans
> to complete this.
> 
> If anyone wants to continue, this person can take this patchset
> and done the work.

Skimmed through, but high level comment: we are slowly migrating to netdev
instance/ops lock:

https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=cc34acd577f1a6ed805106bfcc9a262837dbd0da

Instead of introducing another nd_lock, it should be possible (in
theory) to convert existing upper/lower devices to maintain locking
hierarchy and grab upper->lower during netdev_lock_ops().

There are a few nasty places where we lock lower->upper->lower, like
this, that need careful consideration:

https://lore.kernel.org/netdev/20250313100657.2287455-1-sdf@fomichev.me/

