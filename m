Return-Path: <netdev+bounces-127970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65C59773F7
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 23:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67EF8B21E98
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35B11C244F;
	Thu, 12 Sep 2024 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJgOWxcd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5FE481C0
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726178370; cv=none; b=lUFmsKnGTHU2qnYxdd1Du/VzMF5Se3lD/1jix026OFI5qEfyJND3XLezMrDEs7fjm6Xq/k9ApAjOg309ikuuj/0IEhBH8LeMQySrWd2Gp93ireoM4o8bu2crbqjGfMLAW5oDNQ9WFqHz1dw5nnqnNtIi/978NWzNzaaRHv14S9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726178370; c=relaxed/simple;
	bh=vi4BLmVSFuO8elczl55Ose8iF8StW4hZ9gAYVKrB0jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUP5Iub8Cd1SWxltgTOprIQ3LOqYDnSBC1O/joMH7ADJP6e4iHIamnOtpTsF+ZS7035W8eT8YEzDh5WUgWPKZh+fT4CDz0zmIH1tczsS6TU9+Mk80RNGP/gYGgnH1IGDIF8via0YF4HM3SEbhCyT7xnyvIbk/ZGyAyTQSMbQJ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJgOWxcd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-206bd1c6ccdso2392065ad.3
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726178369; x=1726783169; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WajrMCDSuuAse2oVxx6VE99UxAbtX70RsASGZNxTG9k=;
        b=PJgOWxcdkqo7hLWyq5gUvUVCKyGw7G+cS9N6Me0pEBB7XrZxrdM0B7GNIkV1NEdqoo
         X1PxRQPXB23vEOExYQWk6/YeUHxapweKOpuhp4LA2OR4SRbLypGqaFWOpHLs1t0dVWDP
         fHRx0SwJuUFr/BRnu07kJOB97hiuiJth2vdPczC2ogQfjJ+uIPi3wi9PnkVwFzULdxSp
         PDeDkmTW2Zb9qcFF1P2Ap6XMegGPvYYKfsq7GwMEToYiKlrVcC+YfWOUT1bn8ngAnE5w
         PrdLt3X7jjlUY2rFcMQVexiSfnu09nLnQCp7b8Pmi4gitToXfhxmOawxPypy5eyHys+D
         MDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726178369; x=1726783169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WajrMCDSuuAse2oVxx6VE99UxAbtX70RsASGZNxTG9k=;
        b=VXaMPHCNPYO6vf2sDZ6v1YXqVSa0XY0fmmQFH++JLmje3guDcxc7nxjJQFYuIuo+5A
         HS+VDdABUmYhQa6OPfgFY3t62GYA/BMnlyjbzx9JX7zVpmFXfZheCQepm/0Grbt0ODAY
         i4eFJRtZF9GrC82YrJB9StsWZK7hKnz1urIubeplMQpUUuH6rbxlxiBB7/qDwEwRvhBT
         zspdO5ano0bWWZ6rq52AF+KfKeZQYz5K2OAY82PZEId9pi31Y4WTUnWWnUn/FxlGpG2Z
         nGtrAvjwFFa3eIyf3swXjH+o4xXAT2IP84WyKYJ9IaDDjVjb7Nnw8MkQNGkBIL6Kd7BA
         /CGA==
X-Forwarded-Encrypted: i=1; AJvYcCWgWZFrNeM24yrG0ZZEeNAMGhUZa15z1E9Zs/OtIzqYEe0vAI4LBSYUxY4Zs15qB/PF6NgYuJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+siop2Vcw6+Kz9+fL9+6v4HW93RgPHilRJ5NVsvQfC+fN9RsN
	kWrNC6a1bieFbFuV21f4Y6Pd/VzD5rsiowogH6gttg7I7rhqcNI=
X-Google-Smtp-Source: AGHT+IH2FPObjaRU/bkwqRWBjwxN/1bxMMSej91BGBwjGLmiR/91x7Sg5/I2c1UDTP4c+aD13hz64A==
X-Received: by 2002:a17:902:c942:b0:202:47a4:7a1e with SMTP id d9443c01a7336-20781d5c6ddmr10352925ad.16.1726178368563;
        Thu, 12 Sep 2024 14:59:28 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afdd4b9sm18292085ad.138.2024.09.12.14.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:59:28 -0700 (PDT)
Date: Thu, 12 Sep 2024 14:59:27 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 01/13] selftests: ncdevmem: Add a flag for the
 selftest
Message-ID: <ZuNkPyglAJTcJGmC@mini-arch>
References: <20240912171251.937743-1-sdf@fomichev.me>
 <20240912171251.937743-2-sdf@fomichev.me>
 <CAHS8izNzP_-CS2FyuUo6xRzumMAFRbkE00DOzmHpjBSkMUP3PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNzP_-CS2FyuUo6xRzumMAFRbkE00DOzmHpjBSkMUP3PA@mail.gmail.com>

On 09/12, Mina Almasry wrote:
> On Thu, Sep 12, 2024 at 10:12 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > And rename it to 'probing'. This is gonna be used in the selftests
> > to probe devmem functionality.
> >
> > Cc: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  tools/testing/selftests/net/ncdevmem.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> > index 64d6805381c5..352dba211fb0 100644
> > --- a/tools/testing/selftests/net/ncdevmem.c
> > +++ b/tools/testing/selftests/net/ncdevmem.c
> > @@ -523,8 +523,9 @@ void run_devmem_tests(void)
> >  int main(int argc, char *argv[])
> >  {
> >         int is_server = 0, opt;
> > +       int probe = 0;
> >
> > -       while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:")) != -1) {
> > +       while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:P")) != -1) {
> >                 switch (opt) {
> >                 case 'l':
> >                         is_server = 1;
> > @@ -550,6 +551,9 @@ int main(int argc, char *argv[])
> >                 case 'f':
> >                         ifname = optarg;
> >                         break;
> > +               case 'P':
> > +                       probe = 1;
> > +                       break;
> >                 case '?':
> >                         printf("unknown option: %c\n", optopt);
> >                         break;
> > @@ -561,7 +565,10 @@ int main(int argc, char *argv[])
> >         for (; optind < argc; optind++)
> >                 printf("extra arguments: %s\n", argv[optind]);
> >
> > -       run_devmem_tests();
> > +       if (probe) {
> > +               run_devmem_tests();
> > +               return 0;
> > +       }
> >
> 
> Before this change:
> ./ncdevmem (runs run_devmem_tests() and exits)
> ./ncdevmem -l: runs devmem tests and listens
> 
> And I plan to add, for the tx path:
> 
> ./ncdevmem -c: runs devmem tests and does a devmem client.
> 
> After this change, running ncdevmem with no flags just exits without
> doing anything; a bit weird IMO, but I'm not opposed if you see an
> upside.
> 
> Is your intention with this change to not run the devmem tests on
> listen? Maybe something like:
> 
> if (is_server)
>   return do_server();
> else if (is_client) /* to be added */
>   return do_client();
> else
>   run_devmem_tests();
> 
> return 0;
> 
> ?

SG! That's even better without the extra flag.

