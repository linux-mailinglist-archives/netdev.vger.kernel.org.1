Return-Path: <netdev+bounces-131693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7894398F457
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3890F281E57
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BC81A4F04;
	Thu,  3 Oct 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0THTTby"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E0E186E3D
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973744; cv=none; b=fZXq1f1imz9YJfclhG5JBSq7QfDISd/tWVvPenNcOoQiSW5SGg7MIJryWOXhlna9VcSNOyTC8+WwxmJR3dP3GVZXmzjkGzU3UzrwsKPHOrBh2cVOStZdRxzNirtQn2f+XPnFDAhTLpPpkywW6mp+p7ny+/N4jpnDrBIRl3h3oRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973744; c=relaxed/simple;
	bh=8o+sRM01OWd+XXgs39Ha8NuZmumgT+IDrncAQJmxdu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQM7v4Jq0OPug5HTWl4DRnh3UahI7i4BGGHAPnY1JXiEzTVKLIgpLO0LDr16tEr3eH+Wj3oHzZpxK7O1RLvMJbEfY90qa0q10O8q5m1ByKMAJnweiKLdDXy84VV+Psx3SU7sf2bXTDXXw6GkOm4gVz5nr835kyOo512JDooqXr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0THTTby; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso772122a12.2
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727973743; x=1728578543; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f3i1AL+Fl4nFVekgE13ZA9jN0hH1iDr6CT4aea+HAfg=;
        b=Z0THTTbydWdYhOE5w9TII08Mm9geCaJKUuvH1ZbJNguMKWCkzpp4WUKW5CAmWawXxT
         7VombiXfKCbHWY0hdNbqs2JehOpVKV8LGKB6RA5FRG2+cpoKM3xHX6TNUovMPZre9u/7
         d5ZLYlWRnK9d+faxT4cISDu/4nprxhJ3z61LteH5QZM/phVEhJb8iM08Ipps27P2fs+y
         ekIMkX9U+0mwd85EWvZiKhj389bTZoiv5xqXj9uN65boE9RQ84lrKIRZxZwyDBba3n0S
         cC3w05i89uAKl3T5aaUlOCeeXL2s8p1SfsabqEyi4+JDQy3RNqqGDffhomq17VDb1iV2
         7pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727973743; x=1728578543;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3i1AL+Fl4nFVekgE13ZA9jN0hH1iDr6CT4aea+HAfg=;
        b=Y/pfC3c2O/4N38sbI8AjU9UrsC9eRkyTN1sZynz70DhYUFr54ydWtuDhZXXgs+vbit
         APju3NWtumH01vCkpSSv1rkTt94wVDwKRvF52od0ngDsdEp02x+Fb0vUVKpVYJJUbFgx
         YSdXTXTDYstzdDZ4m5IY0JozyHvbS5wjltGZd+MuVPAB6t8iCP3f+Qe16EksoEImVaxr
         Xl7DzIGxTJPBJUK62nWlVB+lCTm/S02W3VYfBS+6XY50ejFPxovdALpnK0Xf4Rjwbp9R
         /1WcVaS7ExmK+g5x126rq03YF3v66CXhyhCv+HIO9TQHey6q8MA1DJuJxpbnKhHvemb7
         eRXw==
X-Forwarded-Encrypted: i=1; AJvYcCXYRIbrddGhf0sJNhg3K6+ixgCogmMVxYQS/ORThsvL1kTUhNQjZFgXyeQipL8xxl6he6NuPz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9A/NmjA1NSGLqTYtA2QgLBnyHdm3vjPaas04f3TzFVQJDZ9uU
	PW6Ej3X1Na/rgMehwqdjzg8sjPm450VLk2rnf7MmWBe22rWpSYE=
X-Google-Smtp-Source: AGHT+IEnhSymMFEcMMD7bN5yOiGAk4+PaZ9jjlT5bdhWgzNBpRvaY9P4dwoDaAlCS7O1cmZebg6rmQ==
X-Received: by 2002:a05:6300:668c:b0:1cf:666c:4f79 with SMTP id adf61e73a8af0-1d5e2c64d1dmr10894653637.19.1727973742701;
        Thu, 03 Oct 2024 09:42:22 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d7e509sm1558349b3a.74.2024.10.03.09.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:42:22 -0700 (PDT)
Date: Thu, 3 Oct 2024 09:42:21 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 07/12] selftests: ncdevmem: Properly reset
 flow steering
Message-ID: <Zv7Jbf5yVO9eV8Md@mini-arch>
References: <20240930171753.2572922-1-sdf@fomichev.me>
 <20240930171753.2572922-8-sdf@fomichev.me>
 <CAHS8izO0Z6soYWLeU0c-8EKP5monscFqpnw6gn5OkxoqwTxKbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izO0Z6soYWLeU0c-8EKP5monscFqpnw6gn5OkxoqwTxKbg@mail.gmail.com>

On 10/03, Mina Almasry wrote:
> On Mon, Sep 30, 2024 at 10:18 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > ntuple off/on might be not enough to do it on all NICs.
> > Add a bunch of shell crap to explicitly remove the rules.
> >
> > Cc: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  tools/testing/selftests/net/ncdevmem.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> > index 47458a13eff5..48cbf057fde7 100644
> > --- a/tools/testing/selftests/net/ncdevmem.c
> > +++ b/tools/testing/selftests/net/ncdevmem.c
> > @@ -207,13 +207,12 @@ void validate_buffer(void *line, size_t size)
> >
> >  static int reset_flow_steering(void)
> >  {
> > -       int ret = 0;
> > -
> > -       ret = run_command("sudo ethtool -K %s ntuple off >&2", ifname);
> > -       if (ret)
> > -               return ret;
> > -
> > -       return run_command("sudo ethtool -K %s ntuple on >&2", ifname);
> > +       run_command("sudo ethtool -K %s ntuple off >&2", ifname);
> > +       run_command("sudo ethtool -K %s ntuple on >&2", ifname);
> > +       run_command(
> > +               "sudo ethtool -n %s | grep 'Filter:' | awk '{print $2}' | xargs -n1 ethtool -N %s delete >&2",
> > +               ifname, ifname);
> > +       return 0;
> 
> Any reason to remove the checking of the return codes? Silent failures
> can waste time if the test fails and someone has to spend time finding
> out its the flow steering reset that failed (it may not be very
> obvious without the checking of the return code.

IIRC, for me the 'ntuple off' part fails because the NIC doesn't let me
turn it of. And the new "ethtool .. | grep 'Filter: ' | ..." also fails
when there are no existing filters. 

I will add a comment to clarify..

