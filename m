Return-Path: <netdev+bounces-146015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FA69D1ABD
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 22:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3BB1F22FD8
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 21:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215E31E8825;
	Mon, 18 Nov 2024 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="HHxM2NZr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885BA1E8821
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731966102; cv=none; b=khi4dpMggMWy/LAQzoqw4ksyRrqwlXOXB6UupD/tfn6KKfsnJEVP0p2DQS1VYvONkqLeZcmsuBqc8TNTMOgFBNjOFsQBsV/3cQZXx1jqWwcbqBx7GT9LMseiridmFrfO576cuF8XGkpj7djEAMHGXB4DuMrCKAV8YpqL9SWjPRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731966102; c=relaxed/simple;
	bh=m2d3M+FTkemo63OR7J/HilmqfprhTGBVrv4sbnUzhFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLSGbVrd2ntCoL80oI/KhqoSDDE42rfVmBLfmtDCHV8ODa4nvdVF1nJMI5DsuLJvUckXI4ghrWkvPLz63UVv80ujUfnIGi3QEPpOpvd1o8zK+ctqaeehWDfHTNuuF0P5/Y4wgOuymtIhfswygUK/FzjpKPSVh74X22dYPvrIrfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=HHxM2NZr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso212856b3a.3
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 13:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731966100; x=1732570900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBXxIQR8E1xAuFJBBIe3wwO3kWUuAThH7g8w5Nlpsjs=;
        b=HHxM2NZrcvxDUbMJmm6bTM17nQqVVxelvQI+SYSatRDXEARSt/t88MplcQDOAigOwl
         uFkbt9MWDzVbcZcikm63P3f9JjBXyXYg+NxAridv9BsJ55ZJMbBjWIHeRRLJTjKmn0Eu
         PwvhZX/axy+1zHomQ6coCO7ep90ZA/hz4N5kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731966100; x=1732570900;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBXxIQR8E1xAuFJBBIe3wwO3kWUuAThH7g8w5Nlpsjs=;
        b=JXLxBRILx7qtYKoOQ/Os9Om1cU35JRTXS6Ue1QQFj75shwzTfPFDtIGOcr1Aka7U9N
         6ZtwfQCyRMHxeLi28rghG9YpxyHvyZ0q6hhCrgYTDbwO+b5wr1zOwo0+rQN8nCiANH1V
         qL0tLxEf7SBzMxfVfaVIlIXCSGQexzJCFSD5gY4J4ZppX668XwAaJI6YMHJG3oR41ZqB
         jDaiWGckPufTXVZTusx+1Mv4OK2j+FWUQhXOyRhzlHrsTKJxAUZlThlAwRzQGBf/1C19
         g0UpZ9Q2AnC8WxjEPHckQsFUNKaESNLPxaLOSH0VwF9rzUSxcVSuTNmKeEfE543FObWb
         vLxw==
X-Gm-Message-State: AOJu0Ywd6SX65LGfinG3b9cU9I9j4BLvt66JA6VtjyMr0JC9AsPdv/PD
	z62VmVap/v/VbW39lS+eAGZK2Izlb6kyQE9L1QiivOwMUv39Ndr/bxgiZ8/abFXdzWmNUZ7yNRf
	n
X-Google-Smtp-Source: AGHT+IHR7kw3aMqdtZSze5FgKRETnTJeGF1bLpdG1ohdvX/gFoCz0ErTPYKxEyWDpbJP1z0TQme+WQ==
X-Received: by 2002:a05:6a00:885:b0:720:2e44:8781 with SMTP id d2e1a72fcca58-72476bb58a5mr14711779b3a.11.1731966097325;
        Mon, 18 Nov 2024 13:41:37 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0c83sm6666205b3a.91.2024.11.18.13.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 13:41:36 -0800 (PST)
Date: Mon, 18 Nov 2024 13:41:34 -0800
From: Joe Damato <jdamato@fastly.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
	maxime.chevallier@bootlin.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 net-next 0/6] gianfar cleanups
Message-ID: <Zzu0jj6oQT6oOVot@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	maxime.chevallier@bootlin.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241118212715.10808-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118212715.10808-1-rosenp@gmail.com>

On Mon, Nov 18, 2024 at 01:27:09PM -0800, Rosen Penev wrote:
> Mostly devm adjustments and bugfixes along the way.
> 
> This was tested on a WatchGuard T10.

FYI net-next is closed

https://lore.kernel.org/netdev/20241118071654.695bb1a2@kernel.org/

So this series can be submit as an RFC or re-submit in a couple
weeks.

