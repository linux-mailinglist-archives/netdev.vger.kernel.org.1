Return-Path: <netdev+bounces-178440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB3DA77058
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AA41658A0
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35E5214A8F;
	Mon, 31 Mar 2025 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fl3GN46y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C5721C170
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743457770; cv=none; b=JBDrSySDqX4CHczB4X3W0eOyRkIemAYyPFd17tEpX/LHuQvkr6nRcaB8vwAV9I/AA4F7qIaDozekvvXf4jT/FhaJJRIhH+JyMl78sx04JdYiH5SSDHWhDEDPBUJ1uTYiOGd5fOLx/cLJt3cDcnOY0C6di+1i6kmWOidfUjPGEZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743457770; c=relaxed/simple;
	bh=bPl4CkChVYWlcvTsgExN4/rBYhQFlkTurNRyLXCTPhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nS7++5hWaFuZobzz2LVxgYoRJviIo6PIBJdrhUKb79oWuhvTlYULOpR9tW33Kfpq/kXCVM1+RcauPs8G9AV0rwYZ1bG5hEdtOYbPmX4NXNlK2/H0x4Zv5nxdhzfbkFo/fKZ8R2Up3VjKW5IaRHx31vOvi2CBQ74jpTrIppmTDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fl3GN46y; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225df540edcso109145015ad.0
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 14:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743457768; x=1744062568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oTGVyL3j2DWKTw7cMudJiacZbO6jNZKlFvLywZjQj18=;
        b=fl3GN46y/7ek01SaPZlJV2Ah79Te8M+AweXwuU50Fc7EE3c+6tyTTTtrwoj9ko2WdQ
         Xjxtu2iEW0sLY9Jt/CkPz5XGyY6CLlUKuGjx6OHE3KE9ZYi0DyB+NyUHyaIsJg9wkbaB
         F+CzQ99iTLxqTqX9VU7vF0VrpxVr8CHaE2Z71h7vmSiD+bPbM13OcL+Avwy6dra9aSHZ
         6ygeIYenVSraizOBw8B5zN2OqzXTX1GLTDTldRkmCegVD5Anz1UswQ+6KwRr9oOh5wiT
         Vm5+lKkMSO4iD4WMOeyM7cGTzRowgLmykXG91jXGzLG7bOadrAcTUtpUxJlfxYGjobNo
         xz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743457768; x=1744062568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTGVyL3j2DWKTw7cMudJiacZbO6jNZKlFvLywZjQj18=;
        b=ZKb/jFCz4+uuxT0EYBolHCfRfvGy3P5K6JP2U1EhWv0RlQQ1lqTYmD6URMQxcllOvk
         04NY2cGn1OQq5tB5krbj9PgfUXNNXwWE7qPPfwUgq8jZ9kmGUa4taCSLOZtx2U2B/qyU
         IAr3agxXWy3GrgiCxNnHpIq9QvMNpQAv3zyNtrTGQ0FoQGA+ZdYxPl0tUysPo6/IZ54Z
         hHw3ht7oDcgZRZjaoTIeeb9qif4gxrpG3fs52dA9An+5q08RHnZHYCCpp2DLjNr+T1EK
         9vhamg4hW9RYlZMv1nekn8kOK/rtOS/fREZLHSecgudXIZZKU/A4syfh4TMcGQz12ZS4
         yWtg==
X-Forwarded-Encrypted: i=1; AJvYcCURLhr0/jWw08XvHTalM619AGyUaFvFEpq1dyH9sphgD6LQv5znmPAb+qbu/s8xOnHOhb/8rYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/kQWjgJ3rrLcOCDAh6P2uvkMX77VJ6Cpt1TLPI0z7uGe1rRpZ
	SAqbySUBcEUhbE4zVZODeGkcieae/KyC7AFU1xnJQhQtS3v9Doc=
X-Gm-Gg: ASbGncujB6sY+Eb5aAVzAA8OQnbs2qJmE9zPFRpRi0XGV18vu+8kYQebAsCaAxqodf4
	zTbuuzWNhPlW5B0nehR16JXgDqsridJsbRUDYPKM01cgY+eUT+rBK6qwFuY3CFd62nU60V9P1xO
	RlqMAg2K524wreB5uZjQ+y/3QNIk/dELdNCBXjw0BgOGAK8EHXzK0p763cRhOX0/wsWHzMmTwLw
	DOolGRhLdpYJLRT8jNx1IKoCraEUOgADGlR/we70B5+JL8UCFKXJiZTaRN0PMBGugI1QYRRVvaY
	brIOn3QRnYUadUUVvV1ncS/hMM1sm8cup68R7bAjDZs2
X-Google-Smtp-Source: AGHT+IEHeU/ZX/YNk7WQ30v6NY6zvddXn3mswJOAok7sNqVOh+uHqNO7R3/Xf6KNmTxy6NNKXH/HPw==
X-Received: by 2002:a05:6a00:1151:b0:728:f21b:ce4c with SMTP id d2e1a72fcca58-7397f369169mr19466324b3a.5.1743457768420;
        Mon, 31 Mar 2025 14:49:28 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-739710d075csm7504028b3a.165.2025.03.31.14.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 14:49:28 -0700 (PDT)
Date: Mon, 31 Mar 2025 14:49:27 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net v4 07/11] docs: net: document netdev notifier
 expectations
Message-ID: <Z-sN51vNmepkwPc8@mini-arch>
References: <20250331150603.1906635-1-sdf@fomichev.me>
 <20250331150603.1906635-8-sdf@fomichev.me>
 <20250331135825.32acfce7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250331135825.32acfce7@kernel.org>

On 03/31, Jakub Kicinski wrote:
> On Mon, 31 Mar 2025 08:05:59 -0700 Stanislav Fomichev wrote:
> > +The following notifiers are running without the lock (so the ops-locked
> > +devices need to manually grab the lock if needed):
> 
> Not sure about the text in the parenthesis, "the devices" don't "grab
> the lock". I mean - drivers don't generally register for notifications
> about their own devices. It's whoever registered the notifier that needs
> to make sure they take appropriate locks. I think we're fine without
> that sentence.

Good point, I was mostly referring to dev_ vs netif_ calls for managing
lower devices, will drop the sentence.

> > +* ``NETDEV_UNREGISTER``
> > +
> > +There are no clear expectations for the remaining notifiers. Notifiers not on
> > +the list may run with or without the instance lock, potentially even invoking
> > +the same notifier type with and without the lock from different code paths.
> > +The goal is to eventually ensure that all (or most, with a few documented
> > +exceptions) notifiers run under the instance lock.
> 
> Should we add a sentence here along the lines of "Please extend this
> documentation whenever you make explicit assumption about lock being
> held from a notifier." or is that obvious?

Yes, that was the assumption, but let's explicitly state that, shouldn't
hurt.

