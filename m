Return-Path: <netdev+bounces-53900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B964A8051EC
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E527E1C2091F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DED556B62;
	Tue,  5 Dec 2023 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HbYuqE6p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32D39A
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 03:21:15 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c9eca5bbaeso39623521fa.3
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 03:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701775274; x=1702380074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WqRNVRWGQ5rja2qPmMz/REMdEBR0XVbaI4jT2CfbfAA=;
        b=HbYuqE6pX6nXFsTb0wV1EZk2DOVj64/dA7KL30f8Bw3s44T/ONT2THRrXNp9WQ7jtg
         azS+fHacig9sZVWeyDUYXRcdNwT5NSLG3eAg+kpeKgmAAOmdaco5gvw8bBqzBBqggoBV
         BdbqKU+CspYreIjtRtQZ+loVqKCQ8zfTo+3tbAFZzezQwfgI3ugwFwoxGJTHQH8XPFQG
         fzKUSYk/egT/EMDo/sCAUEjthv0pe9GiDU42Yo36GWJrqtVgrhBw82OuOKEWnT+fcf3U
         9A96t9HLTYDj7+Fp80onBEcyAzyCKM8mfAzLsOB6xwgUGzk4lHqsNdR1tlBYAHsP56Xe
         G+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701775274; x=1702380074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqRNVRWGQ5rja2qPmMz/REMdEBR0XVbaI4jT2CfbfAA=;
        b=Q1edQ7n6Ppb/BpK/80Hl4t65Y4XKEE70/eln3afT+VJ4aMcVNrGCGTzMq1nz/7PKsv
         h3IZw19Vbn1eSBSEfqzqmbD5ANJEgf0D58MqgZRcvVhk7wxPGL/d5/mJLSIElT0gS/wI
         6GeZtEfT+OZ2f8uF4zlnzTQ8605S1/3aVDJh2ip9e6RIQDKWygG+NsKztkfGN+vszaGC
         xJ8A+JFpHnWqr89sCrCsmgSJHWFvh2OeW9bREVk5jgdcZD25pf8iryOhoKQULBHfrMFI
         AKNKhQFXJjf09aGoKvWKt1oNwNXkZ9Z5RhpiA9KRlqcGbEHLedJ/jRzEn/Wi5/vw5/9O
         k8KA==
X-Gm-Message-State: AOJu0YzEoCAi4LHZDgOHIAc0U8XyweV23Woxn3xqoPqiZ0+4LY4Sh3jJ
	i/415OvJkrCCL5orWrNRBewmA/uWPF1EinRgYDs=
X-Google-Smtp-Source: AGHT+IFYtXDdF/+88+9jIU9GLaXK1TKmpbgAQr4tKxdYeXi0so4i7kp2pDZFtK6Nxua3TYnzqO/nnA==
X-Received: by 2002:a2e:9906:0:b0:2ca:388:2ae4 with SMTP id v6-20020a2e9906000000b002ca03882ae4mr675008lji.40.1701775273934;
        Tue, 05 Dec 2023 03:21:13 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s19-20020a170906355300b00a0949d4f637sm6508449eja.222.2023.12.05.03.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:21:13 -0800 (PST)
Date: Tue, 5 Dec 2023 12:21:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] net: core: synchronize link-watch when carrier is
 queried
Message-ID: <ZW8HqIgkRwsicjNR@nanopsycho>
References: <20231204214706.303c62768415.I1caedccae72ee5a45c9085c5eb49c145ce1c0dd5@changeid>
 <ZW7gMO9YNjP7j4vj@nanopsycho>
 <48f260af66acc811d97eb64ff1b04ecce5893755.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48f260af66acc811d97eb64ff1b04ecce5893755.camel@sipsolutions.net>

Tue, Dec 05, 2023 at 11:28:32AM CET, johannes@sipsolutions.net wrote:
>On Tue, 2023-12-05 at 09:32 +0100, Jiri Pirko wrote:
>> > 
>> > +	/* Synchronize the carrier state so we don't report a state
>> > +	 * that we're not actually going to honour immediately; if
>> > +	 * the driver just did a carrier off->on transition, we can
>> > +	 * only TX if link watch work has run, but without this we'd
>> > +	 * already report carrier on, even if it doesn't work yet.
>> > +	 */
>> 
>> This comment is a bit harder to understand for me, but I eventually did
>> get it :)
>
>Do you want to propose different wording with your understanding? :)

Would not be better I'm afraid :)

>
>> Patch looks fine to me.
>
>Thanks :)
>
>johannes

