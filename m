Return-Path: <netdev+bounces-91474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113598B2CB8
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 00:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438761C2093B
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 22:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5104516F0C6;
	Thu, 25 Apr 2024 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGn893et"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF79514E2F9
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082503; cv=none; b=m3k33/CmeEoUr66Bg8lvEJyQd9G15RemB89EkfnkNHDhhWD0brd/cKqJnsNa4RDcQUcWgIza8D8gB/JKTW+PDSMT6+h7rHTDGVHXjD5sVHFwnyjojeJcU7uZ0JTQ0mz94IGTVf+FA+CCBGtkq0GpwrbpuBqA4ci5PY2mihf1Peg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082503; c=relaxed/simple;
	bh=klttxZkZSgZ3DZsghzDVzBR6b+2+d6rMvLnyNr/Ky6A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a4z/xrxCKSGSF+goMSclogbVvtAJjhAAZ8FS3DqWJ1gFsgJJ2z4Kgpb/p/QHhJPxuSxIN8RnJJqi13LTgXDSr7IKiCduYrOtvRsg+G39H5d+5LwI7SH+hn7taJ2VwAdnvwyG6DoMIHpanDYlztaEQ3Px/4ZoAcJZGaKfOQX6Qo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGn893et; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714082500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=10EB8JD8eFQ62awPO/uclqEC2RU83uJhAuNpjb8D5/0=;
	b=WGn893etB6xWb7ZZC5ooRtFhrjbPLdD87aA/shJRJ6YAubbOCvMJWxZ0M9synkod/LuexW
	jsgxpc6o2UQWQwJPLyfuyxQDj6t9Y7gZxxWkraxGeX8jv8ToLSFReJmEwEWUkGhGazaXqg
	tKJLcuryX0Vb72C/C2zTrlLHn4duXZ8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-W47XAlzmM1OBzuwsTPd4Dw-1; Thu, 25 Apr 2024 18:01:38 -0400
X-MC-Unique: W47XAlzmM1OBzuwsTPd4Dw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d871086a09so12660001fa.1
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 15:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082496; x=1714687296;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10EB8JD8eFQ62awPO/uclqEC2RU83uJhAuNpjb8D5/0=;
        b=ue0LKHw3i8mTkoDDgK9DA5HGzyY/ruGZO+Xs0rU5KxhBqxRyyao0pqSA0wBvnHJuN3
         B3Mi0BIJOES+/et3vDambt1tRyH+4hPw857sYj+drySIWaxlrAeGJ9xxP4LO0tFFodU2
         4qCGy3b95b958YatkfE2z1M9vpmzKP2iJoKnhbbYO6K/PEI2eqoBwALeJnrm8TFyFpIW
         fzmO4W26zCvRInvLrHBCpTl5qbPtPTPs0ErN/kdi/JE8YIk2s0hefaXgA3ZP1kLMFOuq
         fCM3DNrTOv8WV9yFYnuFE2tuyQZbqKRskbtpePe4KwCy77VeKmxs9Z2lARzqpXw4uqRy
         FTMg==
X-Forwarded-Encrypted: i=1; AJvYcCVKqceV7HubeJRsoHScpKq0IzChzPk0w4mJm7TW4ZrVsPbnrNcaIq6/xaBl4himdDWHKwJMYu09ZTiUOmqn1oiLFxVfSLpk
X-Gm-Message-State: AOJu0YyT2QE9ckyloYmvzHI4FmH7iHBeP4IAAOhhv4r9BSb9uej8+MTk
	LXwwcnJRdJXIAvbA1nPGJZxGwgcgvdxIVpdqoeaag2g37wpEwqE3n9ae0bhdPT3EL0/IMJqc/TD
	hPBxGEbgfWi069xfQdeDn+SuLjtYdNlJYJ0Pl96CANDCoRj19rJiKzQ==
X-Received: by 2002:a2e:740a:0:b0:2de:48ef:c3e1 with SMTP id p10-20020a2e740a000000b002de48efc3e1mr346929ljc.21.1714082495865;
        Thu, 25 Apr 2024 15:01:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm8NOZAbGoDAO9gTfyNd8pkjMtJVBD9uka+bmH/x6q4ADf9V1x2L+PuxHiHii3JJvSfxbhQw==
X-Received: by 2002:a2e:740a:0:b0:2de:48ef:c3e1 with SMTP id p10-20020a2e740a000000b002de48efc3e1mr346916ljc.21.1714082495199;
        Thu, 25 Apr 2024 15:01:35 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:ffa:7b40:24cf:6484:4af6])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00417f700eaeasm28993447wmo.22.2024.04.25.15.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:01:33 -0700 (PDT)
Date: Thu, 25 Apr 2024 18:01:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lingshan.zhu@intel.com, mst@redhat.com
Subject: [GIT PULL] virtio: bugfix
Message-ID: <20240425180106-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9680:

  Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 98a821546b3919a10a58faa12ebe5e9a55cd638e:

  vDPA: code clean for vhost_vdpa uapi (2024-04-22 17:07:13 -0400)

----------------------------------------------------------------
virtio: bugfix

enum renames for vdpa uapi - we better do this now before
the names have been in any releases.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Zhu Lingshan (1):
      vDPA: code clean for vhost_vdpa uapi

 drivers/vdpa/vdpa.c       | 6 +++---
 include/uapi/linux/vdpa.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)


