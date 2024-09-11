Return-Path: <netdev+bounces-127219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B06297495D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 06:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871B3286B97
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 04:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8E618641;
	Wed, 11 Sep 2024 04:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnLotOad"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D8487AE;
	Wed, 11 Sep 2024 04:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726030003; cv=none; b=IyNmzgZM+f3gvKIKrZEpBnE/1Z0GtlciRryGljrIchp77lBAj59jSVfEC2rjdDz/IVccGhCJwFY3UwZOF0edRfIsyEala1QXclUdJLU2rJ1/5evvGbJLHUOp6sCKUMILTPYEGt+znjEecqKi3Tyo3bxY2EB4rqpbXVdMgso0KtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726030003; c=relaxed/simple;
	bh=4TebRZ7G5Re3+jFOUOegUIrmDh/LbahTEEJnNM5yMfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qs26dG+nQNPxAOAAURYnNqpts9I+Jjj2NZmCN7EaUxayOYioA26Yatn/jPmGJrVsFjkefJ9C3tCfPllOmhLeTRzJtxNgBNKQB4DltO98zEpjtcmOC0AaQAJFvOPZ1c5qCM7QRwgPRGf5kHdZ2CltMD/4l1S2cTc4Mtnr8rDsQp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnLotOad; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2053a0bd0a6so16051625ad.3;
        Tue, 10 Sep 2024 21:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726030001; x=1726634801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H/G/ScOSU26GRUuPcy6NcSulAq8QSXGRl9w43gnQ2SI=;
        b=MnLotOadg8/WSlxOXIoRB2BP/dCNXd9DTFz8ZfFjvyGZelebPS9K2BIB69+Y6o06ih
         loB71ipArOzaO6TY3wk4W1wvG+dpgzpqnhYy+w4fP3irqkNCsmRMSj5ElZV15hM1r+wa
         iy1oR04P+6/V3avg0sF1zD4i+Co0Q04u1IhjjrN8diQxOLWsRLhCcu/KnBCgsHu5cvDB
         askj5ifgmIwjwDgGjMr6+ZLMeytS4DbIQtoaIgbS+cC3bT3cW377ADs1tozPUB1lMgVy
         c9o2sWbskrCRLSl4L/0SPY9mbnnXB/Pv/SsrqEkGTHWsAX3bJi/gHpQXLaxdpGjvH5CW
         4sTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726030001; x=1726634801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/G/ScOSU26GRUuPcy6NcSulAq8QSXGRl9w43gnQ2SI=;
        b=pA2Hr+vlyp24jlFKUQ9Q1Ub0pG1sqoC+rSA5iu6SM9IEbRJSZCUzpvRTfLBILe1X4R
         gYdghhQ+4GLGCuXIZPbmWChqT/gkeEaB4lnlPonL0eCoo5msRD4g3IqLiFnbNVmkiUtG
         05bf7eVbieeXLrAbMeHmsKV9yPv2aIVFfRMIHjorQvMXEaM/OiCG5g6ZVZPgpy3Ob8eY
         qmIHMdOR9ScwtZZlofv32t8RYgg5sI0XrG/l3/qyi53p6+/a1h7yfWOcBTDn9gIr2y5A
         r4hjp1BgE/EXua+C5YuPuVZJRvfXE87XY83RYcjGbKBYGDQvF94n8xz5a4jwotHcSpB7
         JD1A==
X-Forwarded-Encrypted: i=1; AJvYcCUjDZXFYhK8Hi83tDlRciOfpgTuH8uXKgdadQ3nN0lWpc5JnbN9M9zyt+TnWtpDk2b8Et/pEwgE@vger.kernel.org, AJvYcCXDBFCw3WlBNxb8NCmBwszQHAemCGOO02OopLfR7eUlR4IBbbe+kxOo3VQYkae7ZT4fLuwqxL9/Gggz3NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWmS+5V33nA+bscN3SI9KC8wD/0/9TgKano6Zb4IIhukcaf0j0
	pzW2Z3gUzjueBlEBMlTCKl9vBlrD6lLmXwobCPf6Dtjt7TiCfGycSlzEsnWP
X-Google-Smtp-Source: AGHT+IH2uwH0yvtvyi/Aa3lbpPoyAM/lvWSl64+gohhr6QN4XnqNKWbz/2hedgmxspicJpsFu8rl5A==
X-Received: by 2002:a17:902:da8f:b0:205:86f5:333d with SMTP id d9443c01a7336-20752208deamr1369915ad.55.1726030001142;
        Tue, 10 Sep 2024 21:46:41 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:7cb4:335c:8e84:436f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d823cf3e68sm5466641a12.34.2024.09.10.21.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 21:46:40 -0700 (PDT)
Date: Tue, 10 Sep 2024 21:46:38 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Should the return value of the copy_from_sockptr be checked?
Message-ID: <ZuEgrvfxJn3IlDi8@pop-os.localdomain>
References: <ZuEL6LhQ8bszGRdk@iZbp1asjb3cy8ks0srf007Z>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuEL6LhQ8bszGRdk@iZbp1asjb3cy8ks0srf007Z>

On Wed, Sep 11, 2024 at 11:18:00AM +0800, Qianqiang Liu wrote:
> Hi,
> 
> Should the return value of the copy_from_sockptr in net/socket.c be checked?
> The following patch may solve this problem:

Yes, please submit a formal patch.
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Thanks.

