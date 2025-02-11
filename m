Return-Path: <netdev+bounces-165027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A335A301A9
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 03:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6C51673A5
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 02:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAD21CD1FD;
	Tue, 11 Feb 2025 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="rgYTXCTj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE3B1CAA60
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739242252; cv=none; b=hdiOTFn6y8ZdTqjIgX4fibA1UcDoOEWvcQOgjhmDcDPDmZfGzhPBHXci0zckoAXrjxTrmTNAWkCNf/3MUQrlR0YOmkmiYkqIAeOqjDxSgKDmA3Uz149oS9S+0gKWH9VfwunzhioZ3tT5A4Obu9Vy2HY0cE5ZFNXm5tkeWNSPaZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739242252; c=relaxed/simple;
	bh=VRrjI00Me/cNAVhfeUoIza0DR3FFrIOng/ndd468AvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVfd/tmQ1aU/EMJJ00uGoWVV8ZrYbcLpy67ZFMc4Dt1NwmPLNsrDC5FGfsU1Mazeteguqrw4ZiVB+l9kggOYuUmXnG5mk85MrLiEdv+umS+z9SR1g2m+qYNWqTrMKcLr2tYkLgNa9VuhuJUP9Cvm4iUCvDtpl7EC6g3zxoc0G7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=rgYTXCTj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa48404207so4994376a91.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 18:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739242250; x=1739847050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Inxmkf7GXwx4Ju5kxyAeSkmwU4lkXnkfugn8Ok+jGZE=;
        b=rgYTXCTjTrFiVFmkTg61tGHzGTkr0oF0eyOk7TPQuftlxao9yeZaVrbbxIllSomAPq
         LbVbcjaDmOSOJhEHSjdEaAL6WD6f4zQyDhfPLfmgWHFOnkNeKa1kvprTji7BAKLasM6x
         faWL0+m5e8UA5hpyjFDqDeglirLafitSMlxDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739242250; x=1739847050;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Inxmkf7GXwx4Ju5kxyAeSkmwU4lkXnkfugn8Ok+jGZE=;
        b=gEQKzWqQHJK81a+e2eIJgPSPlteguoTVYeT0SUbqXeOGirYtgxPfoF/eXnbgF1k70b
         XyTwF/FvEgrde1rQi/LFxsND/WN+K1CVt4eDyfIrYDaTG0OGinjO8Uidgvg2Tq2C0P5w
         pAE294h1IAhn3pRdhSe0a1VI6p8EoKkfLkpKl7znpZrAPOGyyaIOaR9OM9xbzzZe6LmN
         u6qe/PTQAdpZa78JDReTY1z821vAorwLIAli8Mz26bK524P/ly3+TqNWq01+3IUXxW2s
         6cxa0sSRDzKpFGHYU7wKfQr940QWTzgd2Ts27ZuxipV7zRlZdUF7N1mq6l5f1Uxtvxeo
         kiBA==
X-Gm-Message-State: AOJu0YxzLvx+bMmq6OnoJ3fxvX1R8+Vozy+aDhkPTNEa28MshvXbJtGD
	Eb3BsTIGTlfdXDqPE4x8hhIYquO5zoIPwfR29nHp2pwwdO+B8mbso0+QZgCUynvUo5y9Tw7DCr+
	P
X-Gm-Gg: ASbGncsCDT/HNLMwJPNWcc/Tvl1Z9BB5ecr0Z9hsr4pj6XQql0+2rshcs7y2YlHcn7f
	87JQvUM5BlwWomg55KdLuCPd0KLi82aNHCmSkmZuidS0T7Mkv5hkNPQS/SA88SabY3cVd/yF4gE
	i1MVtPY5Sd34eYMWug1hoyc55A4I9PrvO70C6Pi0s/0UeNFDuTh5BaWdIQQFDA1MqlrAhzzVt+/
	deXg2HvD4bk6haLJrHpz1ZnLcaxOdRE+HfvtI2D7yf8SvUCrsf1PSUytG6o/HXhfbMUGa2tixew
	kIlDRavnf6QResnY5JbB1ZMthKZ5+e42J3Hta8zgMGqNfOTr5R0C/uXchW29ZG0=
X-Google-Smtp-Source: AGHT+IEwU9HQiodle9G1DfCEZFuDdCXwxGqXcPc3IIYwRBiVYDyT5p/hIkOvMkdFa3mITYqhW/6SIA==
X-Received: by 2002:a05:6a00:13a4:b0:730:8a0a:9f09 with SMTP id d2e1a72fcca58-7308a0aaceemr11800001b3a.18.1739242250105;
        Mon, 10 Feb 2025 18:50:50 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73085eb5facsm3577237b3a.11.2025.02.10.18.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 18:50:49 -0800 (PST)
Date: Mon, 10 Feb 2025 18:50:47 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, ahmed.zaki@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] documentation: networking: Add NAPI config
Message-ID: <Z6q7B79h73ydzOhM@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	ahmed.zaki@intel.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20250208012822.34327-1-jdamato@fastly.com>
 <20250210181635.2c84f2e1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210181635.2c84f2e1@kernel.org>

On Mon, Feb 10, 2025 at 06:16:35PM -0800, Jakub Kicinski wrote:
> On Sat,  8 Feb 2025 01:28:21 +0000 Joe Damato wrote:
> > +Persistent NAPI config
> > +----------------------
> > +
> > +Drivers can opt-in to using a persistent NAPI configuration space by calling
> 
> Should we be more forceful? I think for new drivers the _add_config() 
> API should always be preferred given the benefits.

How about: "Drivers should opt-in ..." instead? I have no strong
preference.

