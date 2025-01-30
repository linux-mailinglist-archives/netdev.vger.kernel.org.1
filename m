Return-Path: <netdev+bounces-161680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64256A2338B
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 19:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C947A1779
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 18:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180751EBFF9;
	Thu, 30 Jan 2025 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ktm4cvk5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641153B19A
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738260414; cv=none; b=EVGswRsLQcvDopFcASRjXpKLlcUFCrYgHo/kdn5qRzk0KfJ4W0RPvYKXLL+/ygXtn/zJxjHqiIP1snbNNvBbA9pct0hTcxqAkeG/VwYrqUUiOIoTxK+RUE4/4x+mnU6HRnZw/xHlZwLDPyh57NjPS9/srEpqVMSOs+1I0cJ/JbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738260414; c=relaxed/simple;
	bh=zr1W7t4KSvfQS76WePuLjXwJuKAeCp9f8rFkbQqNZGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8fZgRPe1apX1tM4Oa9leHPKrmV76CeRtSE7UdWI5PEFp8B8JwKA/2Ok2k5suupB+rLMODtRjopvDIErOD54/XFkCaL0NyV29gx7KLzHd95Iry/oeBUJDvu+EK9tp2ZKdU0jx4DYszl3AGj9S56yy8xETwRYJ6XaKjPCzO93K14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ktm4cvk5; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467918c35easo15951501cf.2
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 10:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738260411; x=1738865211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RO+KDHSuItRLj+0Z8xqZMTdnxipk8RRX+us7nMFUFMM=;
        b=ktm4cvk5VONApphqlCmhjHN3+LmKqgBv2dhEtqCiMOexHM6KBurOBAU/pb/OnfvKfj
         J3wrsGybCGvstCqsy8c9AtIFO9H45YJxKenhWXfZgwjX7N9+BBAorM5g+LknFvRXhpYZ
         RUTbcUkFVfaKNF44oO2atDJT5ZCe2vU9SNo+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738260411; x=1738865211;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RO+KDHSuItRLj+0Z8xqZMTdnxipk8RRX+us7nMFUFMM=;
        b=qdYMKG2rvGaiPHfabUdHSHBxegj51EDo77TmsZKkXpAhBufiiOPn67wVk/oj5Nh5GP
         vmsY0oxdZxSEHtArvdK650u4GKl4MMtjLavb+ymo5iRMVNEci+7y/mt28rrY2/cGg+30
         7g4Y5HLKaNAUxiipLXgLfDLQoezANi1LZ0jwjuObt1r8aU0Oflrc9YKL0GVrrA3+0cYB
         wRiruaa8DXixQeTf78+cKL+WtJMejXBGILryGNIFRyfKVcLSOeJu0siTmWVA/d4KZOqU
         19AmeMfypMZ7rKQTIqzcQ1jNeR/zIlB8VgEZXpHr3CYLlzJb+3axBnes9qT5Kpid0nlo
         oqNA==
X-Gm-Message-State: AOJu0Yw3CzNU9iiwlBn8Vj3vt4HYQ5t17Ti33WYlGWMuHlq8GgShGDUo
	4dND3c3YceLOFxEnOO3MDIeI6p9PvtE0QWWo28V0dZzshwbwGFT/9vs2C9c/CXA=
X-Gm-Gg: ASbGncvrxB9h/XpQoMtkQyaUHn+HFIbc0eqZvAWdD3PMxDc+YG/LfRc1Ts7FimbDHkb
	Dgt+Nsgd03CI9DiLPQ7g2QwkTzYAqAymN0w6T6UOskjiATZbdrYyolYzG2+jSBkNn8til41MlWl
	JwmL2zA2PxlAU7TfC5n5Y3z5tC+bAxvnn65woi3Dmn+UEv37Zp8hGPXnJJFAuJs/18LDS50YfbE
	x8IwLKj2RpZWP2tGX5cMikNsKWaz6BBh38oiFYZtKQ3WTgMIMjk7kFn+tih5DMCRK4UTDnYc3+l
	6HHGrBWLwBgYk2VqJs4hVhAv0A==
X-Google-Smtp-Source: AGHT+IFggQ2gMaMLIa23tVot0OXC4q17UPp6xQWbmuk2qEXfCSoOMxEfOmVrkUNOHVtHN7awI661iQ==
X-Received: by 2002:ac8:7d89:0:b0:46e:3538:5094 with SMTP id d75a77b69052e-46fd0b6da9fmr99469561cf.36.1738260410427;
        Thu, 30 Jan 2025 10:06:50 -0800 (PST)
Received: from LQ3V64L9R2 ([208.64.28.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0a753csm9133961cf.11.2025.01.30.10.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 10:06:49 -0800 (PST)
Date: Thu, 30 Jan 2025 13:06:47 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, sridhar.samudrala@intel.com,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/2] netdev-genl: Add an XSK attribute to queues
Message-ID: <Z5u_t7Rw77X6VAEs@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	sridhar.samudrala@intel.com,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20250129172431.65773-1-jdamato@fastly.com>
 <20250129172431.65773-2-jdamato@fastly.com>
 <20250129175224.1613aac1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129175224.1613aac1@kernel.org>

On Wed, Jan 29, 2025 at 05:52:24PM -0800, Jakub Kicinski wrote:
> On Wed, 29 Jan 2025 17:24:24 +0000 Joe Damato wrote:
> > Expose a new per-queue attribute, xsk, which indicates that a queue is
> > being used for AF_XDP. Update the documentation to more explicitly state
> > which queue types are linked.
> 
> Let's do the same thing we did for io_uring queues? An empty nest:
> https://lore.kernel.org/all/20250116231704.2402455-6-dw@davidwei.uk/
> 
> At the protocol level nest is both smaller and more flexible.
> It's just 4B with zero length and a "this is a nest" flag.
> We can add attributes to it as we think of things to express.

I got a thing working locally, but just to make sure I'm
following... you are saying that the attribute will exist (but have
nothing in it) when the queue has a pool, and when !q->pool the
attribute will not exist?

For example:

[{'id': 0, 'ifindex': 5, 'napi-id': 8266, 'type': 'rx', 'xsk': {}},
 {'id': 1, 'ifindex': 5, 'napi-id': 8267, 'type': 'rx'},
 ...

Is that what you are thinking?

Completely fine with me as I haven't read enough of the xsk code to
really have a good sense of what attributes might be helpful to
expose at this point.

