Return-Path: <netdev+bounces-186484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE78A9F5C9
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1A71A806D7
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1580827BF8A;
	Mon, 28 Apr 2025 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcFVsFH7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E84327BF78;
	Mon, 28 Apr 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857635; cv=none; b=iNlT2XmHJ2+Z5Hh8hcg/rToKDDd9WLiQ+lSOMxBzoWJGwXZcBNR2qrpyw4CMD6NSUQUzqmvTOs5zVAM/mDkm5pnt6pdsW1q9Abcwpb2/Q3FZJ/9h5wIPOy2QbxEA45iSKFZMTdjVXHnZGguZ8kM0n9dHb9a4t7LgC8qm0QjnHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857635; c=relaxed/simple;
	bh=6+hqWWvM/bPVoQ7YcWV9mBf1mD5+fom9XL9lHBzido0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=T7HOgzL29JZWoO5VTjGZSee3siv+88oYK5hYAKXbW9v732sN5cHXaauyNyi1v8kaSt5OU0kAcVU2tcT4y3i4eI92WgC1NJGf7xnp6eOljuUTZYhlf65VdNqs2aQP/ktUUZDYtzRZ8nLKuF3CjQdV81V3cJFNkX/4R+mbE2lWuek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcFVsFH7; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c5c815f8efso523885085a.2;
        Mon, 28 Apr 2025 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745857632; x=1746462432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gR2t6nEH4LkvFAeGrdjjcvqtm05PmPvy/othqJlAYI=;
        b=XcFVsFH7lExgS1bU0GHZWnKg4yiaNyE2+8tZkbz43vHlaOZLm+fbQX0UYKMd3swRev
         vxjRRe5dVzBkeFrLDEJy+smkvCnr+C5DIEimOu2sih8DCDDeR5KEPvWw+GJWUc5iSmpW
         IUNUMQ0azIqLtJznjF91sww2i+e0wsm21g89KY1lGNrlWu5xViZ8wwQSrbHv7qCsPP2R
         zpcgRiEyJ3XTOyKXGcSmVy3uAQLBqYhTivPY1Rbu5rPGm9FwIu+z/I4UXHezbnAK1k9H
         ovs37x9UQLxcpdxXOf0T0Bi5Zf4mSOBac8DlxVcRnFxqG4yMLB2EfvhW5Nd2ttGKPXih
         8uRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745857632; x=1746462432;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3gR2t6nEH4LkvFAeGrdjjcvqtm05PmPvy/othqJlAYI=;
        b=U9/46kh/z1LDvyz9uOCWzLPMC/E5qTWDriKlawr+0q+XUuZ0haQgrA0ZjTJcOTbZvU
         WjuAh1v1gsy9zPLCo7EgQHs8nMvgNnO5AG1cTV+GZc8inXPRO9CAvDweN5FtQ3hAw5nH
         YQKbEUQdX3CRQz07FqIJRhNjEaFyO7ULAOxxd4SlLgKgJYf9Jja9AG43RtU6msRKiJ8d
         YgVV3c7SUd9kSS3xDKQUB7xk3CevjWu03XpPqfiEbdl36S4jUCYPh3ui9MMzC5aelVvy
         TSUk2slK/w6cmrDzIzNhTwm5JU6K61bmz1Q8rvXlvo0O+PieqyENDP3DVa4B1/GfiFJt
         gEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCl7fKzdKf8iq5YLBRuDRmPr35ZZEBRpnenyowvcht6LD7bN0lijreaElyJwLKUDS9c+5mssE5@vger.kernel.org, AJvYcCWJBOzARc9kXQk+eYqGN3+dCdbHRnQk7p9V5pOEddKWr8ctyHXLYEbbVRVvFAtQYcPzKIunMSYK4u5a8JvMLf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu9umT9U7vtQT4jOCdlH+d2wPGcy6Uh+R2Tyq+R7FwBgE7tN6i
	5w5x62bYM926219lmo8PZEbZ6I8LITMWIGmQg17z8Avk791oPsL9aMo4xw==
X-Gm-Gg: ASbGncv0HA5PXwPGQJrFdY0yXxPLuAiJ4SV6QJATRESOwRZr6aauKjcq4YYd458zrV/
	IIkLK5rBhULsxXnDGhc7YCyWp4CB+3VFqGY9sowuO2CaxBj6v/2JM9CTBu/Wh4hMxPBUONfKqEC
	LGDwLVYrpvJv6BKWq+Xe42ciAmwIbTdyl+VHfFdNZYgNBmgtbzgGOEsZb/p0KEQTYnYeHwAqFEa
	DoWaUSLPSNSuBKn61okLA+XJHdRdoOvpCXFEhAvvzxbaQ+cerlkFaimAAFDKFmT7VppOIVy09ZY
	nldmsqWEn1FsRGjW9bw5gV5xuLIGC4sT6koFg7Nx6TRYWSOwfZNNVAPg/oh2/Sa3rCxkMDOKGCt
	E43K/l6MYb0ZjrTuzd1MK
X-Google-Smtp-Source: AGHT+IG3fhByvyDs11mHfgv7/MiWO10vr0Qts/tjNuSmdV0kFbRGjj9SIETnooBNL0T4vimHGjE+qA==
X-Received: by 2002:a05:620a:258f:b0:7c7:82a6:ec7c with SMTP id af79cd13be357-7cabdd719a6mr60658085a.4.1745857632189;
        Mon, 28 Apr 2025 09:27:12 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c958ea0a01sm640052585a.102.2025.04.28.09.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 09:27:11 -0700 (PDT)
Date: Mon, 28 Apr 2025 12:27:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Pauli Virtanen <pav@iki.fi>, 
 linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, 
 netdev@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 kerneljasonxing@gmail.com, 
 andrew@lunn.ch, 
 luiz.dentz@gmail.com, 
 kuba@kernel.org
Message-ID: <680fac5f5ee66_23f881294ef@willemb.c.googlers.com.notmuch>
In-Reply-To: <20867a4e60802de191bfb1010f55021569f4fb01.1745751821.git.pav@iki.fi>
References: <20867a4e60802de191bfb1010f55021569f4fb01.1745751821.git.pav@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: add support for SIOCETHTOOL
 ETHTOOL_GET_TS_INFO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Pauli Virtanen wrote:
> Bluetooth needs some way for user to get supported so_timestamping flags
> for the different socket types.
> 
> Use SIOCETHTOOL API for this purpose. As hci_dev is not associated with
> struct net_device, the existing implementation can't be reused, so we
> add a small one here.
> 
> Add support (only) for ETHTOOL_GET_TS_INFO command. The API differs
> slightly from netdev in that the result depends also on socket type.
> 
> Signed-off-by: Pauli Virtanen <pav@iki.fi>

Acked-by: Willem de Bruijn <willemb@google.com>

