Return-Path: <netdev+bounces-242120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0FFC8C879
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 02:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACB03B0AFF
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 01:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173FD18FDDE;
	Thu, 27 Nov 2025 01:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYlHwmXJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABD61DFD96
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 01:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764206317; cv=none; b=aa4x/aWq/rgLBoH0niswx0775MBP5XX2e7pI9pjiR3qPi81L2LBpygsZbmyKuM/3f9Jc2X2DHWqMJVtnXwp5OJTpZRX9frwZURTaEuKmE7NcUk0TSk5uxmh2pjIMpHQND5l9vGXHzFom34F0+WpzOMQvwKF6QcEW8vEU0hqMFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764206317; c=relaxed/simple;
	bh=PH7ul1MV2bCe6o7VoEvSIkzwKnJdBCrVBMGpqYORNpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMaSQ5KfVtJw8XNv20MCD/7e5RJ1mPz4XPJrw4wPt71gspALr4rNZ0yur+ecoEpwmfHDLNuQ0WboZ70n3uYYmmR/GA10fixVcI1IZuoaDhxImByrntXq9Iu9JWZ6ITXwwLUMjIAK4eGNkUhUqgIdKbMOI+g73DfPTlC2/cUbkLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYlHwmXJ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bcfd82f55ebso681208a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 17:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764206315; x=1764811115; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=27M+pOrOal8adiyau9oNN2jYYNCbURKuOBLJv3kH/Ns=;
        b=hYlHwmXJlu5vsNIVSBu8cdKh4zGpi8A3j7aFqY3//UfNxhPP7hib49nsJW8JAOJHXu
         bQtdhazEu+whz+44Yg9Myqp+QifhVpZSHJbcn/WjmQR+2DW5QD/0ZgLm4w4lwpzAci9v
         EQyH6yY6glY7o2pIEZrV7UBj9WLo8LAwER1NUAkUwxkhlxkx+afNfcSbIFugd0zguy2S
         1al1lZxxEyvyQDtfcabPSfCcDnJ6QWa0+oQGp0Tgc7vGTg/C+5z4EUn8GKgOym+ym6V8
         t6YQAwWs0daB6gvYhXDknk/+jQEjekmopg6rFY2hSEquDxj7iqp6PpokcqS6s203317T
         XyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764206315; x=1764811115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27M+pOrOal8adiyau9oNN2jYYNCbURKuOBLJv3kH/Ns=;
        b=ULihbdKRg9nJCJHgoEzneyFb9KLQJA40BSBPorrhj9inxaqS3oFbRA3i4RW2O3yv8V
         Mu6q8C4Ha3v2mtWaY74pST+/DQku9Ck60+mqzXD4DEcTG39hzRr49domWeMbnrI162+x
         SGwDETxI8xjsc/O0d3UN2pvPD0SxgaXhG5QcGTfb7eDhufp/P7bkfzzUhNlAlTLXSDKN
         ibz2ogomIwvQURgyJBkY2chf3t/MANypa/JEOpI0Tjf9YiAi9Ii+BRZ4eU1iH9+OXpql
         B3sFgqKyMwWp5cv+K6RXAlqoxUWQQaNUTXzZH2rkA9GNhhV5o38KW5g6rKuKaO9r2Erg
         6eWA==
X-Gm-Message-State: AOJu0YxUpMXeAHA3Ne/4deieFVVsh+Sip1DbD1GS0iLPBKkhQhc2yYIM
	wpnqdQHZFswhyjZRU5lkLfb9fNyx6fPnfKKx+EOvLoNb0kyooqBjVTO0
X-Gm-Gg: ASbGncsOv7eEDI1tci9RoZIF5znkDVNpm2pfRSmNDxNuVc20z/L74AzK8i/vlF8qOLV
	h0CP3OS/2oWEGsA26Y3bTtHW/oewesu1iVkFfcYupTnPCb8o6+A/Rt4rn+TG4y41ltTkFrXHXQ6
	ioOYD2bMn5yxsj57g7sxXibMCTGmsKblhJqTNHklplnq8RW504UwLxVMGqwms5+kxhHDfFlvDgw
	w+4rSBT7v1xjva/Ykkg9YV/IW5RmJeEKwRhYsCoCRkOKmEhwGtB/luBUytElGOBTvVfXQt9qpnY
	rvoHhMMShulmzb/pQH144OM/fOqRksnOYET7T/FCbCw5/ntglMNNAyD80II0m9pNPPl2vfV3Sdb
	f5nhlbNrJwvAwNpIAITuPVmzyEMxBEUBut6X4YUvA1ZQBppTuzOpjWErwo49rSUWyNyA59sOb8J
	LXjKC/CXoKuwZz47EbBqUkFFxQ4w==
X-Google-Smtp-Source: AGHT+IFCLOocHypEdOgX/CKP2sKXALXbpA3eiA77f69Dv9x/D3UOTDdDkYw195CcfBiYBwLFyIh1vQ==
X-Received: by 2002:a17:903:2f07:b0:282:2c52:508e with SMTP id d9443c01a7336-29b6bf0db36mr209189115ad.8.1764206314837;
        Wed, 26 Nov 2025 17:18:34 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b111adasm211316655ad.18.2025.11.26.17.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:18:34 -0800 (PST)
Date: Thu, 27 Nov 2025 01:18:30 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [TEST] bond_macvlan_ipvlan.sh flakiness
Message-ID: <aSem5ppfiGP8RgvK@fedora>
References: <20251114082014.750edfad@kernel.org>
 <aRrbvkW1_TnCNH-y@fedora>
 <aRwMJWzy6f1OEUdy@fedora>
 <20251118071302.5643244a@kernel.org>
 <20251126071930.76b42c57@kernel.org>
 <aSemD3xMfbVfps0D@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSemD3xMfbVfps0D@fedora>

On Thu, Nov 27, 2025 at 01:15:00AM +0000, Hangbin Liu wrote:
> > > I see. I queued up a local change to add a 0.25 sec wait. Let's wait 
> > > a couple of days and see how much sleep we need here, this function 
> > > is called 96 times if I'm counting right.
> > 
> > Hi Hangbin!
> > 
> > The 0.25 sec sleep was added locally 1 week ago and 0 flakes since.
> > Would you mind submitting it officially?
> 
> Good to hear this. I will submit it.

Oh, I pressed the send button too fast. I forgot to ask—should we keep it at
0.25s or extend it to 0.5s to avoid flaky tests later?

Thanks
Hangbin

