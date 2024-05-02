Return-Path: <netdev+bounces-93036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C3E8B9C33
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 16:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A992C1C2143E
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1133113C688;
	Thu,  2 May 2024 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUCDpNY9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CEA219F6
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714659724; cv=none; b=QQlTrtMy7v3ZuvJ3+p/T2NvM59ocQyt4HuNl71CcK5H5qrq2v3xMxoBRI/NsG+AHZ78eTgem9Ii0LD1d0qMdMBTe3QzwB1z3k6343tKd70O5ZkUazuF5IIvpQWvYNCE6rvVw7ATWM5pgGMLd9ogn3pKDBlyNFyDB7uhy3X8ar2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714659724; c=relaxed/simple;
	bh=iEEBqdyC+Rk9LB1HfqbkfdStL39Tv/VK4tdeT2Ki/gc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IYBsEHJDv/rj/rv+0218gBjIbkLdFwTpfRkiRYkBUSh0/bq4LdnjVyLXjz55uu07rCYib/rzVEFr6zWF5Xvs767fMJAVqPYJVbtr8FuoptA12sjKpD/F1+p1ih7QskiVj2Qe2i/yQ7o9bbtHg4pizCdx27krnGf7zdGfG24lJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUCDpNY9; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ee4162061fso2142166a34.1
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714659722; x=1715264522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRNIZi8gLjf6rllWA2KvFoi/rOToUaTJJsdC/tGvvXY=;
        b=nUCDpNY9CboUJu6q84BzNJffKbW7135W/2Wqv0yVxM+466OTVfGdyqVl9zb+McNAG8
         qOFhCQ/SXpNcIRKRKsS1MPwI+6D/9avbJ3XVziAN5pP43KMrwTvBXhGThEFd0hIPJKe0
         T51rU1HX0tvfklUVCT+R3R9pm3rdf4UL6MWDAuDwsMnFFU6xZMG4vcuxorftIzuqPisr
         Lj3OLGhgdpvvN34YZH4QIQbPzJGb1dtaDiRqEuPKyn+04m9smx9dbt/RdTWZh5smnwvU
         PCxzpgB7dwAcTzcsCz5trFa0H0/86wJJF4kKpw5rT5We6eq7JHsuCGfNL7ZfOmztAzFM
         EjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714659722; x=1715264522;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VRNIZi8gLjf6rllWA2KvFoi/rOToUaTJJsdC/tGvvXY=;
        b=eLmW9AaRqCZl7xm1nS60QGLx0W48W9kNiWIFU+qzZNvdYw7+Fd/T0mQ8jWftXMK8zf
         7LBq93TLenZ/tyDVFm8q56ZWB8BOt5AKuEXdLUi8wc6E7iJD/r0SBQftgvS1KO0HLz0Z
         UOokELzHgVpeXQzSJTawfcHEP6C+Q7MUClGcIC95yuF9BmdkTzag1ijJWXpiXlEsVnHo
         aKsOEvYFp83yjFTZNiYT2+vBcJ+OK6xY/WBKO4V7heRBgGHRoN9mvekOGPesjTLr3A4F
         puOqYhhpCnDF3TjPjTxBtfTpH7KX39Kw775k6NZQejNfCFSummcVDI/b8pcIaawfWoZv
         +f5Q==
X-Gm-Message-State: AOJu0Yx9BYPFXfZ4JKrtOAtFGApj8d7aUClzXdlo0I4bcAJzhMAGb88E
	hWtOAV7yWpucsl40qJOEOTAH/OZZ1eVNUdAFJpGvhU+aBW9g9E1M
X-Google-Smtp-Source: AGHT+IEgrt+5umTFalcFYGGYcd4aGEfeoVJuF/pc5qduYS+Z6NfrYF1FGDTZDoVS8npf9ri7LE2ThQ==
X-Received: by 2002:a05:6830:4805:b0:6ef:94f2:948a with SMTP id dg5-20020a056830480500b006ef94f2948amr6233894otb.30.1714659721726;
        Thu, 02 May 2024 07:22:01 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id pe18-20020a05620a851200b0078f0ee3fcfbsm398495qkn.46.2024.05.02.07.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 07:22:01 -0700 (PDT)
Date: Thu, 02 May 2024 10:22:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <6633a18916f75_3971a0294c1@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240502025325.1924923-1-kuba@kernel.org>
References: <20240502025325.1924923-1-kuba@kernel.org>
Subject: Re: [PATCH net-next] selftests: net: py: check process exit code in
 bkg() and background cmd()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> We're a bit too loose with error checking for background
> processes. cmd() completely ignores the fail argument
> passed to the constructor if background is True.
> Default to checking for errors if process is not terminated
> explicitly. Caller can override with True / False.
> 
> For bkg() the processing step is called magically by __exit__
> so record the value passed in the constructor.
> 
> Reported-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Tested-by: Willem de Bruijn <willemb@google.com>

Thanks!

