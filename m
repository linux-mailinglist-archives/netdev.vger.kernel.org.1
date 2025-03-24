Return-Path: <netdev+bounces-177267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EDDA6E6E2
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73E616ED11
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7721EEA33;
	Mon, 24 Mar 2025 22:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jREaYvo5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7741D5AB5
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856808; cv=none; b=t6iFTfp0wq3MD0ikGgULCyHaRQRor7YkSIAWWxxLr294S8nhrz5sEQkTshYgRfI+5hi+6s55vyY5J1FG0J8vR/uiCshMpvdbM0VUo/5FyjKl4yr8F4CJRFynUBEKvULktJnaHJLyg7lGOvxPyLR2ET7+G1APwblT8QuN2ePrm6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856808; c=relaxed/simple;
	bh=ToxbzIYyo3mvRaXjuB9xek6kAROEbqQqma+tRsnVEq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOu4lW0eVVx9yTHd+cQaCiTy593nLa0I49yALimNpOKUIEaKQy3nZ50aZijHlXn7DdhSMMVkXTNrJxwbFZ1V0H8A5PYyNiA3kVWxnbPzZ72aRpMl6+eiMYsDI/DftvwNH4Q4zI/Nqlk7SLDxGG0bhzk3q+v2x6eZ0KY0DT0LGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jREaYvo5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223fb0f619dso99656315ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 15:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742856806; x=1743461606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GY5rtG+txjgUVmR2iB8ixWTB2LUTd4fgsHR5xXKKbDk=;
        b=jREaYvo57MPL+l3RkqhmfTpRRNcCmIgbFKNqqoAO4iGm7R35Sc9mPOUYpCGVsQqVWt
         fHiMnoe4uxn5F9zDBrtSNK066IZ88Ib70jJPmMuGHc292WoLC2qjdOG91ahaFhnA8laf
         80JL19eKq5wgRz66+n2kZ9RLc8eG7fPyh3ikw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742856806; x=1743461606;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GY5rtG+txjgUVmR2iB8ixWTB2LUTd4fgsHR5xXKKbDk=;
        b=EbfID3D9eH722dfOqy70U6qNoQ5KG4IhpF5AVNCv+euFEIzjyjorZLFygk8VDsS7qc
         Ez4YiusHDYudgdCHjiAjkGAON8lSyRLm77Bps3moDWYbNvP/1emNJtPKrh5ErBQJ2qDr
         kbNJLe/8pdtq7ILA2tfSeBc8ewtmeNFcrV5T3HA7efBXUtEO4w6UFLoKVh5UxwJh94Sn
         qcsAJo+R5pJ224V6/cs4FWqiGp3pcJutiKZmiZ+LOPprK/1VVZKzi6CaBuljMSVhe094
         tydVmlG592LDfUdEFPX/1R13KWR+u2J1H4F8qUBHLQnONhmXfBETpfpXNWKevPsnZNXm
         9r7w==
X-Forwarded-Encrypted: i=1; AJvYcCWmOaIxOc/6DLplsEm/iESw62oSGMTBtkiVZ+6LBeOnX7Q313IyTDvK+Mw7rUFDLoXIjJI6748=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3jSbsV+axB+b2O59uF5aMQH5617gn/WDxn8ZZjelBdBACV/l/
	0c3tgHW5aYgYSqENuJZq1oD20JV6BCoHohRBQGIDNyf4uvkJAd4SGN9eD1yTwGQ=
X-Gm-Gg: ASbGncv93OZhYe3HIp2XXaxgB4kXYaA1q2fO1HjM8WB35tiKWrEh8cad9CGTge8f2xy
	voPzldaxxt8cGfZQLDUmDmRkjEEjR7vbT01zmBYXQGNua4tnLWXzrlkiEFtYeyn6eNxBHtTosg7
	u8j3J/A216VURBpvhxnYeOzqbKmvYWAX8w7Zw1zidB+I72oCteVYOxtUCqWs+Q/gRMDpxQ1R1xy
	3VPkZVN1NmO9tsGuWfNgyq1AQeqAbtVx09vuVdn4h2mgmWFSbf6Sn5dY2oSJlYXeAgkOiRNBP6w
	uQMZsyAnZnL5aGY8lYgo7A5gZ9zK/Iunr11XzBXoP36YeG1DT1e6u31hqB4wO9CcUG3pQw7oFrV
	E0mTG9aP6miK8ikA3
X-Google-Smtp-Source: AGHT+IFWobGI3AEkJrBmjG5hbnM0Sj74+gyMoEBB6XT22rPpwcgsE/V0VDJPRGUi0WtMaaGwjcoesg==
X-Received: by 2002:a17:902:ebc6:b0:224:b60:3cd3 with SMTP id d9443c01a7336-22780d80189mr241804415ad.19.1742856806372;
        Mon, 24 Mar 2025 15:53:26 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3b493sm76770675ad.34.2025.03.24.15.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:53:25 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:53:23 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	brauner@kernel.org, asml.silence@gmail.com, hch@infradead.org,
	axboe@kernel.dk, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, "David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH vfs/for-next 2/3] splice: Move splice_to_socket to
 net/socket.c
Message-ID: <Z-HiYx5C_HMWwO14@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, brauner@kernel.org, asml.silence@gmail.com,
	hch@infradead.org, axboe@kernel.dk, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>
References: <20250322203558.206411-1-jdamato@fastly.com>
 <20250322203558.206411-3-jdamato@fastly.com>
 <20250324141526.5b5b0773@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324141526.5b5b0773@kernel.org>

On Mon, Mar 24, 2025 at 02:15:26PM -0700, Jakub Kicinski wrote:
> On Sat, 22 Mar 2025 20:35:45 +0000 Joe Damato wrote:
> > Eliminate the #ifdef CONFIG_NET from fs/splice.c and move the
> > splice_to_socket helper to net/socket.c, where the other splice socket
> > helpers live (like sock_splice_read and sock_splice_eof).
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> 
> Matter of preference, to some extent, but FWIW:
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks for the ACK.

It looks like Jens thinks maybe the code should stay where it is and
given that it might be more "splice related" than networking, it may
be better after all to leave it where it is.

In which case, my apologies for the noise.

