Return-Path: <netdev+bounces-103971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EC990AA28
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 11:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E7C28D00A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 09:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DA519415E;
	Mon, 17 Jun 2024 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Ar4BAu0e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7218190053
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617172; cv=none; b=WzgIraOQN1gMKEAvjhBZY6nxVZ4MqMlS4xIrv4llbfRUYKFfumwg0uKKrQ52/+DQVduBVLwtKNxul1LWHpW5Usx+u9vnEp5RPpA5PtQROJs0qQ+fz1hyL2kaBG9EKU7Zg0i4QxKQS2G8Ku+f3EvBmTNgCNB0Mm/VwsfmwRgvDy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617172; c=relaxed/simple;
	bh=w6euua8DdAndSBqtwxLw75oNhUUVr0fLiGLrdXsOKIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVISotYbvJ3BQQeLznM0SqVDUJS7DIfLVfl8T/OvFJyub+izPzO7m7HuTkzYbMVZyOoNW2AvoGpk/NrNdVZBMvMoFr0eViqK14+HCbRP0hqPs+ujt9fuUvSmLKpnGDW0dEjPJFOQyd36X6tDaEHoIug4jdje2qE2mX6g3X0v4so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Ar4BAu0e; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c73a3b3d7so4663675a12.1
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718617169; x=1719221969; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jWyeWccl/2aEbivUkA2fQdZreCyT8NBDVsWDIMF7kK0=;
        b=Ar4BAu0e3HBjgt8WTbvI3pAaMMjA8Xcg5BJ71MQiIZuYnJkrjvwhF7ke98kMrCmdFx
         7mTfjn7u3dWyKjkUuQ7kDkdGF0Q1aU3EU0DV73rNNIdeAnlvMAmWX93nQcShb/6aCLr3
         XnZQbwbQphyzZvAy3FlTdo1I0jBkl7VF8oZGvMW2nrUHQm0S0IIQvZ9HNMSs3273x7r3
         z6XGk7M42oo+o1yGCHFXiRn1+rofZm08QoaDt2M23sdiAx8r/gG6Dp4dKqC5YedMQ+kq
         WOe1/gXXMdNp0pJjCDZ9EYwPcTnAgAjBEXecSxI1g652zQeTDZjSrpwFmBk8azyqVVBM
         1UeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718617169; x=1719221969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWyeWccl/2aEbivUkA2fQdZreCyT8NBDVsWDIMF7kK0=;
        b=aCmRH2fi88pksKq1rRTqCqDLzPlx67oXc+jJL8QJ2Z3G05YDByXO7h///cCJbmAChQ
         W5U73FmzrFapfVlkFVsYkYX5igZsicYQANg0CqcO1G6LU581irYRND0NU6zDA2wkvbcY
         e4p76hbn9WsjxcTbJiegf4xFyfjj2V4rOfcG7PwgkL6qJ1+yMpxpaBOtKE8w9Z8iM45W
         RtDP6+ZrajKEOVXPZRwbsDXZXsIR4cYllpjW5q9l2AS3/byNI4+GkzPcK9YULnF06pni
         jBmp6oXGeVumdKu5FockFI7ERmmH9drV+PHuThYPMzhja22lN4tYLEXx566en2mfFZyY
         Eb6A==
X-Forwarded-Encrypted: i=1; AJvYcCVNux1panNnPgH6XybUaDaq3K40tbPe07+VibTZHBbbE+XYhweKoyU8aiYMVaQXnMZKsClRlWBhsDWdZS3b4PnPgxUfCmso
X-Gm-Message-State: AOJu0Yx8eGyC0oB64S/odj9UGyNLTua8yboWbKTA4ccMnE2I/FPmNqNi
	r9MDe1FgjNhH+Z0Z/gO+ql9abAhIDqNraBTu38eLNU+28drpjuYpyf6uVRk0THM=
X-Google-Smtp-Source: AGHT+IGp6uk6Ht7TdfIqqo0ajPFbRj2WbXpaBM2/Fev0ZqRwXqgcuvLouIHuUc2CjEsT4jUPUz2Q/Q==
X-Received: by 2002:a50:a458:0:b0:57a:322c:b1a5 with SMTP id 4fb4d7f45d1cf-57cbd6a6d1dmr5264380a12.38.1718617169052;
        Mon, 17 Jun 2024 02:39:29 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72ce12fsm6169015a12.7.2024.06.17.02.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:39:28 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:39:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Cindy Lu <lulu@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	"mst@redhat.com" <mst@redhat.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <ZnAETXPWG2BvyqSc@nanopsycho.orion>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <CACGkMEtKFZwPpzjNBv2j6Y5L=jYTrW4B8FnSLRMWb_AtqqSSDQ@mail.gmail.com>
 <PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>

Mon, Jun 17, 2024 at 04:57:23AM CEST, parav@nvidia.com wrote:
>
>
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Monday, June 17, 2024 7:18 AM
>> 
>> On Wed, Jun 12, 2024 at 2:30 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >
>> > Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
>> > >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
>> > >> Add new UAPI to support the mac address from vdpa tool Function
>> > >> vdpa_nl_cmd_dev_config_set_doit() will get the MAC address from the
>> > >> vdpa tool and then set it to the device.
>> > >>
>> > >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
>> > >
>> > >Why don't you use devlink?
>> >
>> > Fair question. Why does vdpa-specific uapi even exist? To have
>> > driver-specific uapi Does not make any sense to me :/
>> 
>> It came with devlink first actually, but switched to a dedicated uAPI.
>> 
>> Parav(cced) may explain more here.
>> 
>Devlink configures function level mac that applies to all protocol devices (vdpa, rdma, netdev) etc.
>Additionally, vdpa device level mac can be different (an additional one) to apply to only vdpa traffic.
>Hence dedicated uAPI was added.

There is 1:1 relation between vdpa instance and devlink port, isn't it?
Then we have:
       devlink port function set DEV/PORT_INDEX hw_addr ADDR

Which does exactly what you need, configure function hw address (mac).

When you say VDPA traffic, do you suggest there might be VDPA instance
and netdev running on the same VF in parallel. If yes, do we have 2
eswitch port representors to be separately used to steer the traffic?
If no, how is that supposed to be working?

