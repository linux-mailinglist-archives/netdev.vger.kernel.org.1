Return-Path: <netdev+bounces-223171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2971B58181
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 18:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618CC4870DF
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A4F2459F8;
	Mon, 15 Sep 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMPQwAv4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED9523D2A3
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952210; cv=none; b=KmDVVyFCKe7UriTO7e6Jm1EpN5ELcOwhnRBYHlVBEiDrNlDi6lMCU0Uqam1GIBEUxe2a4QYi3R9Asi4YmKZirpIJ0C9OyrQBiVEH3DVI/rs9EPj6CvehuZghjGQRWWBujS1ifOpH7b5T/9BaJ8tRCpd3gQ8Qwu/yFpmf6Tx368I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952210; c=relaxed/simple;
	bh=jZv2I+hQgy7h1flHxtjAdMVXtLJV6Xkt1tQmvJyMaYw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q3Jvz/1LnJetitkzPE12C8XzkPMWqpXbcmEmIhS4PJR82982tKWYuwn8l6ABc+84yzavbpSE+JwFWPcQjlkA14VN7SsQ3CE5J5i2yqJXwJ1HfqonL4Eb139BQCLIqa5WjBmyTVd8yJ7u+tTyYjkejaxsws+NNIGXlxdi8b0G3BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMPQwAv4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757952208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=l8M1HLgoXiLY5BzoOeoK/zpN6LMaZFeM6/poF/2GC8o=;
	b=UMPQwAv4iioyGSzoYU8O8AGkvti+Nm0r7MemJ9ntFlYsr+3wck2lj0X0J4XWxf160JGWgl
	uk1LNatlxXR7l6hLZy9i3R+1DNHmRH85Q9b+6XNPc30B6y6tn1IwhblVX/HV0Um6lj6aWN
	gKMmYJQRXlShsIlyIcU9/vYBhnnkUSI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-K2cw1d6-PGan7oi90TH6qw-1; Mon, 15 Sep 2025 12:03:26 -0400
X-MC-Unique: K2cw1d6-PGan7oi90TH6qw-1
X-Mimecast-MFC-AGG-ID: K2cw1d6-PGan7oi90TH6qw_1757952205
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b078ab1c992so527501866b.3
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 09:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952205; x=1758557005;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8M1HLgoXiLY5BzoOeoK/zpN6LMaZFeM6/poF/2GC8o=;
        b=uMbJceMnS46OgHL7/vdVXEnDwwdpxB173AisTEfMS0YwX+hQmPhBtZ9CaE6M0Qnzaj
         nFzeZzIKyDmdzJyu7YcSdkcc20D6hh32TBBgB94hB7hvBrXtW+Rf/I+XDqr2jt9N+ZDt
         2q1p9t0eVpQ+jPKMj3wl2YqznBYORVOV2QnxzlVKWobsNEC970q5oy85qm2Dz2QkjAkr
         7CAuw2vnf4XexXjB5xc54v/QvXhUM4HxVPBIZ4S7L4vvbVL2//LKPirjVXi46PYGp0eu
         IxW7YoCnyouiBMTOHveK9cp/acx/FUSIT5NZKMkAsmeVVvi42nhrTfpXahZyiph6uNSx
         V1nA==
X-Forwarded-Encrypted: i=1; AJvYcCXfwTLW1ZyKA42j2fzKUoVNNikedA8bVNJ2646iN5bBk6eeSHkqHtaTuaG+X9rZhnnQp5uNUHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBKeh3I4R5AyT/GdHUt5/KdEhAOTgxmZ4EWh0WB/uAoSqFYfpu
	zUs1x6kDDOVusLwUGZz7EM1MS1RZrWhXeIxq7tCwZmWNLaCJPmVWy9KJpfDCKaeuQWTwpMix0Rv
	UxbJaP+ZL57VoF0nfUMzgDeCypSHAKBJkdDHyhC4p8VbMG5xJnAh8XEEqQQ==
X-Gm-Gg: ASbGncsZ/dVBR1HAIuDpM1scd7VaOuXtSEGzS5EsPdJYLDwdbp1KfYI1hvwFPHT8ymI
	x5JHaPn3buU3T2ALbUL2kiuCluLdU28RGxgRDnBl16hgtB0oaffI2NN4szYefzfd42aDLzsQLde
	A2Ql3VSFV3SN5jdvGHRT1ppoim+o8sOEkCrekKtsidHIDPQy6isW+5kbWq/Pgn/f/d4NtxoGYKW
	4lDwk8HTArbSU55ojJ+sSSA5jOaiZMvf3jSm3ULHvhjoCTIUwl/C5/PuKVZ4ESfvUklCPnCdo9C
	+7yeFYh3h0g00aovI9yJJ5j2OX0h
X-Received: by 2002:a17:907:1c1d:b0:b04:a1a4:4bec with SMTP id a640c23a62f3a-b07c3a67aa8mr1299549866b.58.1757952205511;
        Mon, 15 Sep 2025 09:03:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwwIB4rLfw0BfbhWfF9Fcdmo+wyMaaAb5Z+Vosd8vM4TIyjSy30sdafKcHylRnmXkyEaGRuQ==
X-Received: by 2002:a17:907:1c1d:b0:b04:a1a4:4bec with SMTP id a640c23a62f3a-b07c3a67aa8mr1299522466b.58.1757952202060;
        Mon, 15 Sep 2025 09:03:22 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3128a1esm947877266b.29.2025.09.15.09.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:03:20 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:03:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, netdev@vger.kernel.org
Subject: [PATCH v3 0/3] vhost-net regression fixes
Message-ID: <cover.1757951612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent


Two regressions were reported in vhost-net.
This is based on a patchset by Jason, but with
patch 2 from his series split up and made simpler.

Lightly tested.
Jason, Jon could you pls test this as well, and report?


Jason Wang (2):
  vhost-net: unbreak busy polling

Michael S. Tsirkin (1):
  Revert "vhost/net: Defer TX queue re-enable until after sendmsg"
  vhost-net: flush batched before enabling notifications

 drivers/vhost/net.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

-- 
MST


