Return-Path: <netdev+bounces-247318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC64CF748F
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 09:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66B19314B61A
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 08:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679E232549B;
	Tue,  6 Jan 2026 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jw29zZzF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qmxw2hJW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5A8324B32
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767686244; cv=none; b=QRrN4A0Cl8cMQK1QGe1+LlGMSu7edub1a/O6mGIdPSANn5dnMpzea683hFnWRXi+Fk5Wn6sL2yCLmDsHykbwacHi4sH7foHMSAELMTv5RFnGau5onpbOqMUe3sauoNuU0icDTLwEFU9SzDNafPt0sV60/cl4e9ba9zFiI74noqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767686244; c=relaxed/simple;
	bh=2dfXE3T5FZ6K7+lqEmh5QGLTAful/RxL5/OXaLyX+Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsMIreYQ4f82L1kpfPXcp753tuhPv1U5kToelBXBFfD8jZha45JHaL3Se9Mw1EFSYms/Jog5mSn3PFBbPXv0+bs/+Jh6hOPtrCzEBLYJr0AJmMIejR92edMdI03DQU3C9z7Ml5zWCaAPbs53KM5DRP85PCx7gA+zKe7M1ViRlU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jw29zZzF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qmxw2hJW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767686240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I4TYkMIrp7AW9u8pmueM8oRPi406uK0ebNKTuLEzFRw=;
	b=Jw29zZzFglG919JgI7i0xklQ2oObYZyc5leVLnIfHti9CJweJNPNRzG8C5PabdVmP4/3fY
	M+7UoQk0lJjSmBkBb7s9m1F/B8AYBTpQLUP/nNuyP4dtnrpMhO1TRrPHTSZfGnUDm1nqke
	v82l+dtoQG1lYYlghba+tsFch4GvB/Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-RGgkfVoKNb6h6qBbbQllZA-1; Tue, 06 Jan 2026 02:57:18 -0500
X-MC-Unique: RGgkfVoKNb6h6qBbbQllZA-1
X-Mimecast-MFC-AGG-ID: RGgkfVoKNb6h6qBbbQllZA_1767686238
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43065ad16a8so338580f8f.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 23:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767686238; x=1768291038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I4TYkMIrp7AW9u8pmueM8oRPi406uK0ebNKTuLEzFRw=;
        b=qmxw2hJW+AO3suKcri3g0TiipoHvog8sdITC2QHMfTikjaSmpW7cDwLvgpyCmWE3BV
         YZHTlAhNH3Ld77C3rSJDl7qLfmi6uonpPkNtWk2AoqMX1zsl1asvQM/7pULYuKhgRPAl
         uG8kydPbhb5+EZomulY6MR54kupmNG/Cj2BjPTpR6IMirp5RPjC0P5NDFK0sE7n6mPZB
         ZkPckHR/fFFL4RRyxt2toE+qHQ8APlZ4j3qxH+0Pzer9qpfAmiDlebvJc36bjL6bSBlg
         0bt2USGb2uDkIx9JDAElaNdi2VekN5kHFbsMifBSGSs9F4FOQ7/QCGiM1nE8jYaL273T
         oskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767686238; x=1768291038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4TYkMIrp7AW9u8pmueM8oRPi406uK0ebNKTuLEzFRw=;
        b=Y+zG1741hZE+UIBqWJI47/JXhLoI3//4ExPA+mFl4GzifTMpYuYGksV6QVoW2Kd/Ro
         MSyzJG5Te/snB77yevLfgJth6l8IAejtwvYcZkQtIs4lgexUHh9toMGxoGiJ3mwH/+NX
         f/kYHiqbPukaKo2Wvzmg52t5W/aR2D0DBsnpsTvqvHMmfiBB/TKVi2GQ+cxIT8r/PjeC
         yagog3IqnM9Uhhmhu/dTWE7EkMQgkVEpiYmMTtyDbsIYYB37v6EUDOSILgEGMTGxCCst
         E4erICsNloxE/gVIjY/mvrRk6l8AC5IOIy/EV6ZVsM1G/MB1V46LsfjSMPpNs4kzn7p8
         ZILw==
X-Forwarded-Encrypted: i=1; AJvYcCW9GdygPnxB1R5QQlxy5hPqWNW1A6cgn5juSIrfu7covBnmam6Sr98l10+Rx0MUgMr6ChA7HGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeR2V+PIyLcFWsx8zFRwJFw38MrPdsDsPZMt7X0pw5hcLdUqgy
	fkHA9dVKZOOdjJYU3QRxLV0/JShiMDmWB1/seW0rlwpCTUGrvPSEUFCAM4tyX1aognnTYrZdPl5
	NomTMpCcUdx3bPOZRtj6Lh7HjQR2lgkJ6jAnrLd7LxmsZ2vJfeiogbW8yyg==
X-Gm-Gg: AY/fxX5t3xy87BcUwrNdu5tYjNkYKRM5QW55OZOaPNKtHRJnj0AW+wHnqx5uU0Ese8L
	DWoiTU8Bes1pbjJP2oRAUza0nl4bRN5mIWdGpKd4OPHYGAHq4xGT5QKmgy0JHSWwrR+c2zP3rHf
	4gDmHx3gDkQrPj4betwU5xxlGCHMCch0okGOB9H7dAqMtzz4HwdmNP1arIftebc7UlBhiOGO9CQ
	+EJLluH/yJEBPTGH4GliqvyVYGzYxvGCeLUZSfxMLj3F8BT03WTnMEeGkMtsctAZ/Hgv4WneI/c
	wn+RMQFtr+j+UI0a6QmjMtOAf2xMs5feNb6Dh42vHoX8Ga0ZadqFuNC1WF+GaaIjisKl8P1L1hl
	VRZFgzNwnwdTrpahkNZmhBh73kvZfF+QIgw==
X-Received: by 2002:a05:600c:444d:b0:46e:32d4:46a1 with SMTP id 5b1f17b1804b1-47d7f09ca36mr23148225e9.22.1767686237595;
        Mon, 05 Jan 2026 23:57:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkOtxCvNvgEtYJhHLldkg64fSo56Dqfda5jX1IeA0WMV+CtMRCrIRIjLAWwju8ZN5FopMEIQ==
X-Received: by 2002:a05:600c:444d:b0:46e:32d4:46a1 with SMTP id 5b1f17b1804b1-47d7f09ca36mr23148085e9.22.1767686237184;
        Mon, 05 Jan 2026 23:57:17 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f65d9f0sm28518895e9.12.2026.01.05.23.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 23:57:16 -0800 (PST)
Date: Tue, 6 Jan 2026 02:57:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+a9528028ab4ca83e8bac@syzkaller.appspotmail.com>,
	eperezma@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [syzbot] INFO: task hung in vhost_worker_killed (2)
Message-ID: <20260106024033-mutt-send-email-mst@kernel.org>
References: <695b796e.050a0220.1c9965.002a.GAE@google.com>
 <20260106014632.2007-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106014632.2007-1-hdanton@sina.com>

On Tue, Jan 06, 2026 at 09:46:30AM +0800, Hillf Danton wrote:
> > taking vq mutex in a kill handler is probably not wise.
> > we should have a separate lock just for handling worker
> > assignment.
> > 
> Better not before showing us the root cause of the hung to
> avoid adding a blind lock.

Well I think it's pretty clear but the issue is that just another lock
is not enough, we have bigger problems with this mutex.

It's held around userspace accesses so if the vhost thread gets into
uninterruptible sleep holding that, a userspace thread trying to take it
with mutex_lock will be uninterruptible.

So it propagates the uninterruptible status between vhost and a
userspace thread.

It's not a new issue but the new(ish) thread management APIs make
it more visible.

Here it's the kill handler that got hung but it's not really limited
to that, any ioctl can do that, and I do not want to add another
lock on data path.

-- 
MST


