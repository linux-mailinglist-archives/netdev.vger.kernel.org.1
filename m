Return-Path: <netdev+bounces-68094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E8E845DD7
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BA02B324AB
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F411E7E11A;
	Thu,  1 Feb 2024 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EW1RXaym"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13416157E85
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804680; cv=none; b=uXDc7bFvyLmtTRzK35nC8Mx9Nt4DpKMdS/qhjGcmfk6RFH6zQaseXfST0+NsED5yP649BNrtK3UMq/0JYwAwuvqJu4ZmH7tk2qAYZukBpfGJQdadEG2ukhA87p+3cT+EhsjABHWQLKZxVQA436h8qilRd+v6ikIqkrjULfFdG/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804680; c=relaxed/simple;
	bh=APWoK8gcAcO801xSDSZ22IQW3H8rp4/dFBB7fy4fvaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/qm175AW2x8JugJoWgxRqAGvaZB40xHzMKUvILy9an1yCGfjiCnJiMzwoNMVjbZVbANrRr+3BPk+pO1wYANdMxea13ogfHelxYX/SeykKakxgD/Ta2d1orqrBf0pUC7nvcFC3qwu6WTn/lCryyKMEYOIq9x48SFr6QXBCVpikU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EW1RXaym; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-40eacb4bfa0so9702915e9.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 08:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706804677; x=1707409477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4jm2Q7ndYebk+zIyllOhWfO+o4jnVrjmyeIPJMGASzI=;
        b=EW1RXaymCrbz0bnst27ygrs5uTqUfxhwpTGPhFwR4OinVWg3Hf+bAlY1WtH59HrvjE
         p/lZjlqpIFeQebHeWGczHqkmva/qhk7PJWuqMk3T+kU3YQouQR6OCqdNqnlqqiMLBsaO
         VbC7Hj7IjDNKHT2KwkAQ4Dc5NcentYwxfgaj3v70pNwLDiz1l4SB17fZK8STCQpHKMFX
         QOHWDtWVmF0/TI/1SxX5u+6I7ke83ND9XcPYnQdKSDsyupdWFY3N9ZksUwQ3CLV93mLZ
         jlvEGBDagvsdD9UdKxgeF5zSlMg0lnXNMRX3OHsHsXTp60OALI/HgEOqKTEDv8u2lgfF
         2t8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706804677; x=1707409477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jm2Q7ndYebk+zIyllOhWfO+o4jnVrjmyeIPJMGASzI=;
        b=lMLQOwGxb5/EdZEuVZjI4zcuguuVwGdedxUYJoxu+UFAG2otr+HF0+wpl8VCj2tNYa
         tRbYDCntAB62Y/kKLu+0ME5u80rAfPSE6kEFmEEWaV11GAG/DWdCkpWSbxoczxuQjx02
         YX2U2N0wkiol44hqneOKblP/8ntWK9yImoGUL6RO8ZXsbMFBlq46FcC9ufOTP/3jTlT/
         sTYHHd0BQnPObyurUrQRdNfqhLybPPsfNs1PGDrBiora9kVrMxu0VMXZsbzhgtrJwpsz
         TVZ+h9MXTE3XqLNgSq9ooC/rcI/GAojuoOoJXVOt7iIf9zr5jT2O0XdbwtzPAkiltLr3
         q9hA==
X-Gm-Message-State: AOJu0YwaqSGp4eJXCTZRqhNLlO7zhEsMsS303yiivWGfxXwzOymGnBVI
	j2yJ9FNy0yOEPGjr+9BmN4oppO1x/rGHfyfeuyS/7L6M4RML9e+rjg6JQCofgHQ=
X-Google-Smtp-Source: AGHT+IGYyqLR9noA49n6HjJ+husoyNmZXX5n8IQoyrc5guzxALYE4SU9FLHTynhW587YUs0qvU67fg==
X-Received: by 2002:a05:600c:4e90:b0:40f:b2aa:2da1 with SMTP id f16-20020a05600c4e9000b0040fb2aa2da1mr2386306wmq.7.1706804677148;
        Thu, 01 Feb 2024 08:24:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXxKX5y7iDyCR2DLG0Td/NcVtXoMQztJVcYWi/Sica65kxvjFUuZpdYtdZrMUQvAs74OaqvyoFAq0BqahrNTmcqn1qxF6GHmT1lTRlGAV+dhlRSoVQcV1e1fqebhB3N3yvkbg/C2QP8+3vsDhuTnJ5UhMJyotL+5SUfhTDqGgSCv9Ws9i6UFWg/QWLJfWVPjA7QDwS6h8fMAm7tFK+LrGMx538ufKpq5gv0dGE58MdtZ2u+8cIv2nlcg0zay3zpqAZnln50rd5TaImObdshmUvy1ONwxGxzqHAtdAva6q549ZzOUQ==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c155100b0040ee4f38968sm72907wmg.2.2024.02.01.08.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:24:36 -0800 (PST)
Date: Thu, 1 Feb 2024 17:24:33 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, olteanv@gmail.com,
	atenart@kernel.org, roopa@nvidia.com, razor@blackwall.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org, ivecera@redhat.com
Subject: Re: [PATCH v3 net] net: bridge: switchdev: Skip MDB replays of
 pending events
Message-ID: <ZbvFwVSQI1M_2WZo@nanopsycho>
References: <20240201161045.1956074-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201161045.1956074-1-tobias@waldekranz.com>

Thu, Feb 01, 2024 at 05:10:45PM CET, tobias@waldekranz.com wrote:
>Before this change, generation of the list of events MDB to replay
>would race against the IGMP/MLD snooping logic, which could concurrently
>enqueue events to the switchdev deferred queue, leading to duplicate
>events being sent to drivers. As a consequence of this, drivers which
>reference count memberships (at least DSA), would be left with orphan
>groups in their hardware database when the bridge was destroyed.
>
>Avoid this by grabbing the write-side lock of the MDB while generating
>the replay list, making sure that no deferred version of a replay
>event is already enqueued to the switchdev deferred queue, before
>adding it to the replay list.
>
>An easy way to reproduce this issue, on an mv88e6xxx system, was to
>create a snooping bridge, and immediately add a port to it:
>
>    root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snooping 1 && \
>    > ip link set dev x3 up master br0
>    root@infix-06-0b-00:~$ ip link del dev br0
>    root@infix-06-0b-00:~$ mvls atu
>    ADDRESS             FID  STATE      Q  F  0  1  2  3  4  5  6  7  8  9  a
>    DEV:0 Marvell 88E6393X
>    33:33:00:00:00:6a     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
>    33:33:ff:87:e4:3f     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
>    ff:ff:ff:ff:ff:ff     1  static     -  -  0  1  2  3  4  5  6  7  8  9  a
>    root@infix-06-0b-00:~$
>
>The two IPv6 groups remain in the hardware database because the
>port (x3) is notified of the host's membership twice: once via the
>original event and once via a replay. Since only a single delete
>notification is sent, the count remains at 1 when the bridge is
>destroyed.
>
>Fixes: 4f2673b3a2b6 ("net: bridge: add helper to replay port and host-joined mdb entries")
>Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Could you please maintain 24 hours period between sending another patch
version?

https://www.kernel.org/doc/html/v6.7/process/maintainer-netdev.html#tl-dr

