Return-Path: <netdev+bounces-128183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0D5978684
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82DE01F21DEC
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8DD83A09;
	Fri, 13 Sep 2024 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtOEAPvV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA69E823A9
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247710; cv=none; b=KKt7vL+uibNG3s2AAkFb8Titti7eG9StpXNMCzv7i4cVICWGRGt4GPUa1rTCVvuI+Z0oWtB8C4d04xpAamXXR6+XrWZ/Zrlkg8CaE05ySEAScfHc1Xns79PeWnCluTKrFcI1kjqrMlPqM/hHFUBB2PKwYv8g0XQ/1K6BQUHO2jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247710; c=relaxed/simple;
	bh=uDAZZDzHPI0Mkya2v35i0INLS321D6D6IesHtwdAHhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ug0NqZGWp/+9qw8CNuKjdN50T4DcJ7pulV5K1YVj167glThhaXkUUHwAnUDMAX0CVfJc/cyG4QIxa47mnWBJ14oJ85dUAiiYvlsMBdVaok87D5aoR5QoDYvduz0s4y1/+XRzux91sVRKzhv8xyjyESmtR/U61POvrXDucAcyjWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtOEAPvV; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718d704704aso2236342b3a.3
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726247708; x=1726852508; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dKahi8sDS0v9vzNy+FTeDPC50w7LG0FgFziJ6PY4pqM=;
        b=UtOEAPvV/ACkEQfEQJx/zgZmnCYaIqnhmolmPmobyrv86gagTnpZatvMqNck26S/0U
         ILUTJFkReMD1+GDnqNGFAf1zsFrqiGBx36JfwRa5CPUMiGzpkQ+yF9qShKOCvMo1c7NF
         BgXlmBCYHNvUUyfqEDDYeLRiQMs7NkXmfTF97FBmStPRVTCVnUSvc/2q2fJueJ3Vg7G4
         Z6Y4J07KeNmddETuUUQKSAAbpwW9G3jXR0hCgiBxpo0BcEnbkWr9zEq5u1EVQuVqgvV8
         7dkMkOvXw7Pgsx5oiSP3VIPe+rcB9tW98xL/XR2+Ryh3LNQsyAkZJtosRNFNL+zVlQuz
         g0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726247708; x=1726852508;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKahi8sDS0v9vzNy+FTeDPC50w7LG0FgFziJ6PY4pqM=;
        b=awTuocJinIKB6uVjZvY8XAeikHIJSmVjCjcG3XuTB/qVEHdWJXnkFf73lnykA0QIt5
         9PcQGYOuuq3HkTmNJ5+rjD/K8JhhfF6fijLDCXZkqLSw08pk6WEQorGsb4UppqrVZlFq
         Plg4D5ttVAnIzjrA5QTTDgjRWTq9OQn9IkVh+6EdqXaUFQgf9/xFyJ07tIxg9n5OUE0U
         R9QJYTvyMnSDUMnGjwtrzl4bJKdwfsDVET96l+DqONIx7FalinI7CVbMlM7x0psvASmR
         jHeDrs2RHU1S2D2hm2fkj7sKbQpVBtV97aPufHo8Vxa9irFBCLtn7Vh+c6GqS6bWYNFV
         632Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeFv9Wxo92fZISMSyIPERVmmhaOCweQybcWj1dZuRUQXAmItmjLukK3PyhzuWnI5KRnhx8Na8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHzoWh65m0er3v4ZBx3WJvj9kbu1MdQDpkY76RvXhUM2SD18l6
	AhRTWhfkOJK+NvFHtc3QW7nkbPza8SoS5DtI1Prqk9n0mxkZw8+cpVBp
X-Google-Smtp-Source: AGHT+IEQN5c82yK67rfAVvKUhGbPywwekinAmmAipieHcMS5CZxQumy4sqhaQZc8XrOrO/iIEfT+4A==
X-Received: by 2002:a05:6a21:a4c4:b0:1ce:d1b0:bc5e with SMTP id adf61e73a8af0-1cf7615c226mr11158392637.27.1726247708043;
        Fri, 13 Sep 2024 10:15:08 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090d5204sm6320042b3a.209.2024.09.13.10.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 10:15:07 -0700 (PDT)
Date: Fri, 13 Sep 2024 10:15:06 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 02/13] selftests: ncdevmem: Remove validation
Message-ID: <ZuRzGmedL2LfTKXw@mini-arch>
References: <20240912171251.937743-1-sdf@fomichev.me>
 <20240912171251.937743-3-sdf@fomichev.me>
 <CAHS8izNOZMeNi4WNWL9jmLd-rJeGA=M3zBKDSzMNHZ3sZOxUuA@mail.gmail.com>
 <ZuNjz7HvlD4z6dR8@mini-arch>
 <CAHS8izM+J3pYi3Ut4q4RCcm68zL7LSjz9-9Fz=OAU0CjexBSGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izM+J3pYi3Ut4q4RCcm68zL7LSjz9-9Fz=OAU0CjexBSGA@mail.gmail.com>

On 09/13, Mina Almasry wrote:
> On Thu, Sep 12, 2024 at 2:57 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 09/12, Mina Almasry wrote:
> > > On Thu, Sep 12, 2024 at 10:12 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > > >
> > > > ncdevmem should (see next patches) print the payload on the stdout.
> > > > The validation can and should be done by the callers:
> > > >
> > > > $ ncdevmem -l ... > file
> > > > $ sha256sum file
> > > >
> > > > Cc: Mina Almasry <almasrymina@google.com>
> > > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > > > ---
> > > >  tools/testing/selftests/net/ncdevmem.c | 56 +++-----------------------
> > > >  1 file changed, 6 insertions(+), 50 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> > > > index 352dba211fb0..3712296d997b 100644
> > > > --- a/tools/testing/selftests/net/ncdevmem.c
> > > > +++ b/tools/testing/selftests/net/ncdevmem.c
> > > > @@ -64,24 +64,13 @@
> > > >  static char *server_ip = "192.168.1.4";
> > > >  static char *client_ip = "192.168.1.2";
> > > >  static char *port = "5201";
> > > > -static size_t do_validation;
> > > >  static int start_queue = 8;
> > > >  static int num_queues = 8;
> > > >  static char *ifname = "eth1";
> > > >  static unsigned int ifindex;
> > > >  static unsigned int dmabuf_id;
> > > >
> > > > -void print_bytes(void *ptr, size_t size)
> > > > -{
> > > > -       unsigned char *p = ptr;
> > > > -       int i;
> > > > -
> > > > -       for (i = 0; i < size; i++)
> > > > -               printf("%02hhX ", p[i]);
> > > > -       printf("\n");
> > > > -}
> > > > -
> > > > -void print_nonzero_bytes(void *ptr, size_t size)
> > > > +static void print_nonzero_bytes(void *ptr, size_t size)
> > > >  {
> > > >         unsigned char *p = ptr;
> > > >         unsigned int i;
> > > > @@ -91,30 +80,6 @@ void print_nonzero_bytes(void *ptr, size_t size)
> > > >         printf("\n");
> > > >  }
> > > >
> > > > -void validate_buffer(void *line, size_t size)
> > > > -{
> > > > -       static unsigned char seed = 1;
> > > > -       unsigned char *ptr = line;
> > > > -       int errors = 0;
> > > > -       size_t i;
> > > > -
> > > > -       for (i = 0; i < size; i++) {
> > > > -               if (ptr[i] != seed) {
> > > > -                       fprintf(stderr,
> > > > -                               "Failed validation: expected=%u, actual=%u, index=%lu\n",
> > > > -                               seed, ptr[i], i);
> > > > -                       errors++;
> > >
> > > FWIW the index at where the validation started to fail often gives
> > > critical clues about where the bug is, along with this line, which I'm
> > > glad is not removed:
> > >
> > > printf("received frag_page=%llu, in_page_offset=%llu,
> > > frag_offset=%llu, frag_size=%u, token=%u, total_received=%lu,
> > > dmabuf_id=%u\n",
> > >
> > > I think we can ensure that what is doing the validation above ncdevmem
> > > prints enough context about the error. Although, just to understand
> > > your thinking a bit, why not have this binary do the validation
> > > itself?
> >
> > Right, the debugging stuff will still be there to track the offending
> > part. And the caller can print out the idx of data where the validation
> > failed.
> >
> 
> Sorry to harp on this, but on second thought I don't think just
> printing out the idx is good enough. In many cases all the context
> printed by ncdevmem validation (page_frag/offset/dmabuf_id/etc) is
> useful, and it's useful to have it inline with where the check failed.
> 
> IIUC after your changes the frag_page/offset/dmabuf_id will go to
> stderr output of ncdevmem, but the validation check fail will go to a
> different log by the parent checker. Matching the failure in the 2
> logs in megs of frag output will be annoying.

Yes, it will definitely be more annoying to piece those two things
together. But I don't expect us to debug the payload validation issues
from the nipa dashboard logs. Even if you get a clear message of
"byte at position X is not expected" plus all the chunk info logs,
what do you really do with this info (especially if it's flaky)?

For development we can have some script to put those two things together
for debugging.

> > The reason I removed it from the tool is to be able to do the validation
> > with regular nc on the other side. I just do:
> >
> 
> To be honest I don't think the ncdevmem validation gets in the way of that.
> 
> To test rx, we can set up regular nc on the client side, and have
> ncdevmem do validation on rx.
> To test tx, we can have ncdevmem do tx (no validation), and have a
> script on top of nc do validation on the rx side.
> 
> I guess you may find the lack of symmetry annoying, but IMO it's less
> annoying than losing some debuggability when the test fails.
> 
> I think probably there are 3 hopefully agreeable things we can do here:
> 
> 1. Keep the validation as is and do the rx/tx test as I described above.
> 2. keep the ncdevmem validation, dump it to stderr, and ignore it in
> the test. Leave it be for folks wanting to run the test manually to
> debug it.
> 3. Move the validation to a parent process of ncdevmem, but that
> parent process needs to print full context of the failure in 1 log.
> 
> I prefer #1 TBH.

TBH, I find the existing ncdevmem validation scheme a bit lacking. It is
basically the same payload over and over (or maybe I misread how it
works). Maybe we should implement a PRNG-like sequence for validation
if you prefer to keep it internal?

How about we start with what I have (simple 'hello\nworld') and once
you do tx path, we can add the internal validation back? Both sides,
with a proper selftest this time. For the time being, we can use the existing
rx selftest as a smoke test.

Or I can just drop this patch from the series and let you follow up
on the validation in the selftests (i.e., convert from 'hello\nworld'
to whatever you prefer)

