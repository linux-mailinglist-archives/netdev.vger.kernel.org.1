Return-Path: <netdev+bounces-156964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3F1A086BE
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 06:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26521162290
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 05:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC5E2066C0;
	Fri, 10 Jan 2025 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIQEBeLn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED38624B
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 05:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736487886; cv=none; b=B2NDhsNNVoaywe1Q+VAxT60d5ahgabQhL5x2FLe09z92noMaI6M9sg4WB2bPqBM9MVlsw+D+Iz03Jx7UEJ28ZtQorAPnpyCkXjRpuxL3K9TY70nwqKk3QBzXklNcfrYJ4wRWtLuTmE9ArPrKlQ1aQEWPLs8lQRN+V+e+fUBtvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736487886; c=relaxed/simple;
	bh=BtslHBnnp5aDKIUm/gUiaf+5YBDSMg58QGXEBd2rDq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJsgTVwYkzGtjIUwRjQeDHfweh75lYZDVrdVrL9MU5Ta4bZtKFdqXPVHYjgQ85sJXpugozVsV/+rorKNYr0s3OCpChXp0HFAeTH7o2dwI0yT1iVIhM4pAinRGUh2RNOLfmmphAxFs3FkwOqsa3wytX46HSoIc0xX79q+6OfdPTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIQEBeLn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-215770613dbso20511885ad.2
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 21:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736487884; x=1737092684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BtslHBnnp5aDKIUm/gUiaf+5YBDSMg58QGXEBd2rDq0=;
        b=LIQEBeLnB2HGk9rNQhree3XS63LMs4IWN8xofPfYTs5I7HKEYKmK9ifO73zSSgaDkR
         nh2JgV5mig0+ZTBGbp5e07ugHCyV9AdPOPRzhaZEScAqarA2kmd/3kwBrwOBB/oxROIB
         mDbOJQYD7UlilynRQmUV/ZfLBrTgXqlFOjmglsNnDeVfuKEO4Ez7/h7hDtkc8xRMO4Zq
         /9W/vWeucD7pmdQS0+v86xQV407+QV2axoAAWITac24PRUcFhk2dzNVZPUMxitUB+Hx4
         VHTgiTMlraCfXp2OmhaCXTjtlTgtnzlJ5WwghN4uYxqyt+zjKAeYl8G6R9KPSS765/5z
         OU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736487884; x=1737092684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtslHBnnp5aDKIUm/gUiaf+5YBDSMg58QGXEBd2rDq0=;
        b=l2qieSQqZxhkdXJmQPAkdoNyQeCLxcTF7I2kTd6xh5IgPYderkGGdgv2l/rZZoOgCA
         p7t3KHKfcIz+b2sG2ApnuAgkj0vhuG2JIv78Y9E7Vl0jgcvTYq2J9sKKfS5sqoeI/88d
         CPLpFEnS87rDgw9PSI8ezRf3UGNFhor6exY2UYTf1P8/uSqFEzgFAQhGyjE9myvrVGYi
         E/mPcvvb/DRhw3rfrbpfu77na/QpMW1u1sz12AMy7qDiojy/xEGT3HRWpbJf6afRXD05
         jmUL8eHwSjWRSrWGTRIr0lhusaYzagQdOyToN6EYVPEeVSIykKEuXKruP3brzLk3WmpY
         yzdw==
X-Gm-Message-State: AOJu0YzfmImzmyWS9NOVtvE89dlExkcenRsenSglZAok4UvoHVmSk7A0
	ISt6dOE6md0nKijXBtltMA0+fgIzO6kAwKMpji6oMRapn6VKErHo
X-Gm-Gg: ASbGncs4EZeXuh6tIGZkPG+aK1dpBlhbkvRz7idTOoEmMmYUzKoc1cilvYn+FmFPzPi
	ieA5X2LiPKQqnSw0K/cyKVQKDwyHZ95+HGZiX1ZRrfMQl2NZZIksdaZQvo9jvlMu04MTB+a6o5O
	JmWLEmC2RaSkrSYakIW0uz4zwGtgyrkSoeCF769PspFa03k4VMH2yK5+cCJ7GQLao5SGIklPVGZ
	9r6V9VN90/thtlCnbhqZpoHPiebxdy0vxdb+gADHQgoLXjpgOIgEX3b8jwRPYs=
X-Google-Smtp-Source: AGHT+IHYjl8vjxY4e+4OPzT0qubGJ/k6Zaz+ZrfIB1kpm5n3s+z4i7bAV10+kF8EHfOVPaFUPMkidg==
X-Received: by 2002:a17:90b:54cb:b0:2ee:b666:d14a with SMTP id 98e67ed59e1d1-2f548ec8a90mr15512206a91.17.1736487884119;
        Thu, 09 Jan 2025 21:44:44 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:c586:91c7:b7f1:d942])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21ada1sm6799575ad.138.2025.01.09.21.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 21:44:43 -0800 (PST)
Date: Thu, 9 Jan 2025 21:44:42 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, security@kernel.org,
	nnamrec@gmail.com
Subject: Re: [PATCH net 1/1 v2] net: sched: Disallow replacing of child qdisc
 from one parent to another
Message-ID: <Z4Czyqq+yrnMkRa2@pop-os.localdomain>
References: <20250109143319.26433-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109143319.26433-1-jhs@mojatatu.com>

On Thu, Jan 09, 2025 at 09:33:19AM -0500, Jamal Hadi Salim wrote:
> Lion Ackermann was able to create a UAF which can be abused for privilege
> escalation with the following script

It would be nice if this can be integrated with TDC (or other selftest).

Thanks.

