Return-Path: <netdev+bounces-249320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAB6D1699C
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 05:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2804630124C5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFF534FF56;
	Tue, 13 Jan 2026 04:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LK84SrVr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED1D25A357
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 04:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768278095; cv=none; b=eh7xLRjXXbTg6vdAAe/x4tuUJFsz6U3Hzqp6toUGbsUvdt5kUXk0AqPEzKwp/fb+BmoUac37JUaHBdQuPRFGhiQOg73MkykAXso7hrxcS/lYpSFMG/RoUp5XJyuzQjW44sSunvU9RBMFVeVlYp+KawJ8Neau41ZyLzm3ZoW+fJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768278095; c=relaxed/simple;
	bh=9z2ygHADRlPRv6GZSQG6Zjqzw6mYA3L1xkaQe+u4lys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbmY6xka/rpgSjmyXJmRk9Q9BEFgs+gwqyoteqFbPuTB+O1q/ZFhJDlUM8M8PJcId5k0jG+vN0NE4oMgia+zG0yUOHDphRpHgWZwJZIqa0KigXq3PYBYtur+u6fkMPe9scaYEfIFl5hXawhI2togZhpzIqWbpykJGWANdb0rdKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LK84SrVr; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6481bd173c0so1323154d50.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768278093; x=1768882893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9z2ygHADRlPRv6GZSQG6Zjqzw6mYA3L1xkaQe+u4lys=;
        b=LK84SrVrXJNVZPVLIoozNS5LeTKIvH+RgeTeIAtfUhGtnUFLW/iY2dS2rY5xGc2tAe
         r1a7cvOHtdJEIxddrlGvJ1s5cm2wWhSNM+6ZYvwYlWom35cGKq+0KY6ps7Q4kx3p11tz
         M5E0uslt3VK3RjgRQnJBxN71W6pBV7iQW/V8WqVfzFDk8+I5zESu8aI0D5cj4nk9X6Jj
         HVKGA3AH3FOoGQdGbjqrdwdCVOkaRPs84TH4kDzchMVg3sZEH4ROBEsqz6/elbnWNNNj
         RUF9tLCC2TuQjJSodnOjJjalRbL+NrNpBptSQUjUFLKiAuZgba35ioi1ZeTYTgAKDg+x
         c6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768278093; x=1768882893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z2ygHADRlPRv6GZSQG6Zjqzw6mYA3L1xkaQe+u4lys=;
        b=uEES4F5FoZds6vFvG2F01BjCx/mn8ffJ4puvQv10VeRfu98BFrkyzcP4eu7aBT76Lb
         mGCNtA3Cwp2CY++DAUHeQIHph/yXa8GIxBh4E4WWqgElf+9cCGtPkU4X3TcGb9q6mW6o
         XiYRY0kK4IO9qVIvtWzAsO7R7UKFSdzlJK4iVyVODmshXvSiY2m4xOe/I49BTRUA7O7x
         43TcitP++iIMzMVKIC5UgEpP+GeyszC7Bd6EaJN73BwrZFomZ4Nr5CpnMliJIY48vUbu
         TJHURw5rmnc6hC4uWkNMTBa7uokjEGOcL1zLEoLAbW5iLKe1xIEQYzJcmnGQUgdQb+9i
         CiiA==
X-Forwarded-Encrypted: i=1; AJvYcCU5kKo+HXjWfCdvwuU+BjxGiSj2rU2w/DM64XKfXBIvM+Fxdwqd4z0fJiUH35xsCN8lj3Ud1w0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3w6CXJ0guHTq3E00aQynE6hA69LOEpy40UEpGzF47ukVnT97Q
	TwHnADHZsFcOuoNoJ2Qgm82mFehOo1qikQvvgCDcgiNbbjLXQW0+3hde
X-Gm-Gg: AY/fxX7VBuT6mXkw3QwP2HbT57gNsrWgeranD6a1BHrxOkjCTtbNRY0Vjqd6c+qWLfd
	zK/hozwk58kRdqoTLX51f6yGC8c2CIJ7RPXxuvT9USsMQPBjr4x0g2hOINh7oqGh1C0kJfuZ/v1
	dEKMAmwxVQcMHIi99ILdtiZ98M/lmGvj2weD4/uIomrt285YLytVS0V0e0ZDUKp1A4ucJO1IMOS
	nvRULR3bAakVEvSA1sWjmfeHx5raf3BqMmlyekCax6XquUuX9EFVXyt8ohnc8vwiiu1KhCnu9Ct
	OQo7V0MBquPym4COflYiFKoc2+E39eGuHksJI51Ei6Txr1y6tsIikW1maEYeC4AsopWZy4vdq4x
	kJmmPbqRoap5882CeuUhXjK6ktDg5tIt0SvzdiZB2vMPzZMiEr7AussVPpWjAiIrXm6p27KEqoh
	6cbWDLmjZfajPl3pt6RW0X/E0MZvDzEhweH32EX1tj
X-Google-Smtp-Source: AGHT+IGGcZLGkIPFIQNjOBHEDejVFdSxvol43+/5acwy+R+srjitlMp64hasZauwcNrOFpf7o0YCkA==
X-Received: by 2002:a05:690e:12c6:b0:641:f5bc:6999 with SMTP id 956f58d0204a3-64716c7a1b8mr16140967d50.85.1768278093158;
        Mon, 12 Jan 2026 20:21:33 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6ac1c4sm76004817b3.45.2026.01.12.20.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 20:21:32 -0800 (PST)
Date: Mon, 12 Jan 2026 20:21:29 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Woodhouse <dwmw2@infradead.org>,
	virtualization@lists.linux.dev, Nick Shi <nick.shi@broadcom.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>, linux-clk@vger.kernel.org
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
Message-ID: <aWXISRWpkW-oHyUw@hoboy.vegasvil.org>
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>

On Fri, Jan 09, 2026 at 10:56:56AM +0800, Wen Gu wrote:

> Introducing a new clock type or a new userspace API (e.g. /dev/XXX) would
> require widespread userspace changes, duplicated tooling, and long-term
> fragmentation. This RFC is explicitly NOT proposing a new userspace API.

Actually I disagree.

The PHC devices appear to user space as clockid_t.

The API for these works seamlessly and interchangeably with SYS-V clock IDs.

The path that is opened, whether /dev/ptpX or some new /dev/hwclkX etc
is a trivial detail that adds no burden to user space.

Thanks,
Richard

