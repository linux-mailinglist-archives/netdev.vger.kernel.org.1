Return-Path: <netdev+bounces-177853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E99A7218B
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 23:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCF417963A
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 22:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF90189B91;
	Wed, 26 Mar 2025 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyUWOShu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C9A2E3364
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 22:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743026575; cv=none; b=OnTjaPYarePCZKhIuM0P01P7SqoQffWdhN7HAxVwbDJrzwIy8bQcpWj9IgkVqGr/XW3DWZ5OG2oU7sUp3JKxD9NZV77yauzPwbZR2PPLGVdktsnLSWPMotRH8arbEAwG1ULS4gvs7014KqhH6QanmPPgF7q/PMzQ+5GSI9zQwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743026575; c=relaxed/simple;
	bh=daFbXvHWf1PTSD2BUSfYos0isuU7GsgEQ7IjXMAwJQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8a0TvCY8qhWoOwE8wV2kM8ZAL/y0iq+SyI+n5LtM6S2dI8c/tBW1dGiJIvFmRT6vjEpClzWeOs4ySwSFef2De/iB3cApzZEpbfgFD4RGNeXzmwqPu698AnYFe8F+njCuS4J5Ts/kYkqDRPX+Bbnz96Sa/+N4bTydhTIeqm94Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyUWOShu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22438c356c8so8151255ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 15:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743026574; x=1743631374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=puBBAdDwjOYGbRqVU8VzXX30JcKlK5sX7q7a6M3Bz2U=;
        b=EyUWOShuu0OJI5VXYQtNKei02w3Kq/ga47gROZUOY5ooJq0SONCzpNnky5AEt1g7It
         HsiiJN2VLukpNJZhdkmGFLAoL63cGTvRrh9GDlaP9pRnTvX0v84z/wRV5MllPRbGKRiU
         hvUFG8q05TREoOJnakIeHrsDkmmgDyzizdDQcWPCsKzwU8MFSbEXmj9N1yMNf7dXSmkR
         JHUdiwTAP1BaIqkzKGRJOpmvptm3bYFkzVUPPhq7WEtD4WiKBdzgcBP4IWsmW+We/Kmr
         uwnkm9yNnrJx2V5wG7LPcEFFAXLb/53Td+PG15FjOrcWS7o9dZwNCFep3MxbSfePoS7p
         ydnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743026574; x=1743631374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puBBAdDwjOYGbRqVU8VzXX30JcKlK5sX7q7a6M3Bz2U=;
        b=YkI/UJfw34peK9pQ+wnbAS1uws2rjelirAtg8AbuCpgmxvUwkq35m+Y5vvFCIykMO6
         kPWfyHXh9nj8035uIgucFEuaZw0TZr8HuNwwh+kSUVUTjlrUMvL7aKmLC47qQ1ZRRPbt
         XT9xoCP2D0o5tZwjjOaaAgApAAmBfmNzaiTZmo6js2f+NEnwXuJyuSFkbK5MJL1y4IEs
         x5Dxcg9h2Y0lsMLz1KYA/4jRixuxE/Hx1uPXRuD3IiYqswg6tyeU1MelLQrkOqnbiCyS
         UiGyQnKrI733fVCOEQOW6FYqAXEXFBbXrn+rfvkuTY1RX41VB/tchaD7I4Tl4BjghwiR
         aEHA==
X-Forwarded-Encrypted: i=1; AJvYcCUKC46cknS9N1c+Yb54kVQqj/Ex9K8b6Xnm+KZnGtO5IhYl3F8laL4FDp8i9BQFXduAZQIVnfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPhYFyhdyPEF13wxA/w0EKRZYlMIvz7wU6bSWLnzg4XiqEHoci
	x1V7SuQ09AafFDFbEHmZlRqX+omHMpkJsE+9FGWiTB2+MfItc6c=
X-Gm-Gg: ASbGncuNT2Q6vxlT0R872cOFNRnbLPOsm+VfnITD3f6MccUsoutiSADKgzKhlqpEU9t
	uMFqnSjhjQCD7wMSCXMG15ICGc2reIKygOApe/49DJBmAug4AGfasa3I5gAcpvsU35sR3fYsscj
	W1AS352rXw5Gc3KiCNSfGIT/RSC8DqOJYh2tYiJqVzB44CU6GQ5+KzONDBqQ3nnvIbx3DIDrjCV
	J66ov3I7V6HuHaf+Fu8FKRqhpxviJv0hkWmKZFz79Q38szk2KHDjD20zdnJ9oAygpHuFAET8NHl
	RGiPyvfkz75TnSwXCKl6raKfqFegvCOXNU8VT3Vggijx
X-Google-Smtp-Source: AGHT+IHjmjScN04l0XsHiavdEj9fAUdrlE8NWjx5vSemQ7WqddVYEmm98P4kH4Bw82roHMIAQTSETA==
X-Received: by 2002:a05:6a21:6b01:b0:1f5:58be:b1e9 with SMTP id adf61e73a8af0-1fea2d2f26dmr2520971637.4.1743026573641;
        Wed, 26 Mar 2025 15:02:53 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af8a2a233a8sm11432942a12.52.2025.03.26.15.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 15:02:53 -0700 (PDT)
Date: Wed, 26 Mar 2025 15:02:52 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: [PATCH net-next 2/9] net: hold instance lock during
 NETDEV_REGISTER/UP/UNREGISTER
Message-ID: <Z-R5jEo4-WRZr86I@mini-arch>
References: <20250325213056.332902-1-sdf@fomichev.me>
 <20250325213056.332902-3-sdf@fomichev.me>
 <86b753c439badc25968a01d03ed59b734886ad9b.camel@nvidia.com>
 <Z-QcD5BXD5mY3BA_@mini-arch>
 <672305efd02d3d29520f49a1c18e2f4da6e90902.camel@nvidia.com>
 <Z-Q-QYvFvQG2usfv@mini-arch>
 <e7cbdbf24019ba5deac18ccf5eea770d4c641455.camel@nvidia.com>
 <66a15c52d68a2317dfa65093ecd227b0ad4684cc.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66a15c52d68a2317dfa65093ecd227b0ad4684cc.camel@nvidia.com>

On 03/26, Cosmin Ratiu wrote:
> On Wed, 2025-03-26 at 21:57 +0100, Cosmin Ratiu wrote:
> > 
> > Am I missing some locking annotation patch? A quick search in net-
> > next
> > turned out nothing.
> 
> Soon after sending the previous email, I found
> netdev_lockdep_set_classes and saw that it disables deadlock checking
> for the instance lock. With it in place, it works.
> I also saw your other email immediately after...
> 
> With that in place, things seem to work fine without further warnings
> for a few quick tests.
> 
> However, it seems that this approach is dangerous, there is the
> possibility of an actual deadlock with two concurrent
> netif_change_net_namespace when the RTNL is removed from that path.

Yeah, netdev_lockdep_set_classes is not pretty, but it should do until
we solve the locking for the layering devices. Which is another can
of worms I don't want to open in the current release. We want to be
in a somewhat consistent state before jumping to the rest (dropping
rtnl for ethtool, properly fixing notifiers, upper/lower locking).

For the netlink path, we are very unlikely to remove rtnl, so let's
deal with the ordering when and if we get there.

Thanks again for testing btw, lmk if you hit any other issues, I want
to unblock your (Saeed's) queue management changes.. I'll try to post
a v2 later today or tomorrow.

