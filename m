Return-Path: <netdev+bounces-76070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F6786C32E
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 09:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9BF1C2126A
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 08:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A99482DB;
	Thu, 29 Feb 2024 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQjrVSR3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F994778B
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194255; cv=none; b=mhFIzKlxgFVihTGaajiC5LK0lrrh+Qt0OSEfbv/4PApsIjAScGf2vbf72U3i/P6dhMalKwFEtB7tS90/1qnVv1LAwxDFf7qOBPX4x+MfKIcsPl2B7NLc0YJCMlMCm+0fVFrfGiWFSzcTLY3WcnL9G6XnAj65c+5KKrrfddWg2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194255; c=relaxed/simple;
	bh=qCPcUgnQ03I0sXgFA/1uHQrrogGfD7B3vS4JjEVRmgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1zclWrEU39aYOievt23V6H/PqDo08UrdWPqo5VHNFin1rh9D27+GxlcZA7gTdLUNJgkL4BgvD1LFbECdvG5kEQxEXneNWSBkWJEzYHBbPhufneyZ3r3a7hMqBJFrP3Oy5eVvQph94pdM0wjGX2M8CJT8Mx4khkCutez7+/ycng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQjrVSR3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so34355e9.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 00:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709194252; x=1709799052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ef/d9IHnIvhP/e1H7tN1OHDxCtRbXUe2/bR+CpZdzxw=;
        b=XQjrVSR3KVJUJ/qeKpcqQ1fBEVf/5DWZ4BJr4RXfyrDOgbEyagEPI29mKkHnSqxss8
         q36Crk7VELg9RuQ76thxOwpTxm/ddFnDsOUjpVfyNe9RLYe0pwZ9M3LmbRpxVso7KLm5
         EW1f0q18vTaGqTvUtn6AwXyH/mpSkclq9/TbNLltZZFRN57WGtZKOrxUXY0Ely8dJ/g9
         D+C5lqUdheLmhT11uhoWR1r6X+3bYYMgSJyfJCR8Ak1XOdI7Vltb3HtLp2YJkZCyBS43
         E5g6HbiKWlB+BO72OlI7QXtMEl71d7y3BQyypa3d9amy4KDkch6L14IgNpeRVeKENZvY
         uy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709194252; x=1709799052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ef/d9IHnIvhP/e1H7tN1OHDxCtRbXUe2/bR+CpZdzxw=;
        b=C0CNw8UMRkl3mRNcr/oIUu4czbqQq/5X7eyKxLbu/kDQo6Dbwb6pJLoNM/8Iuvuia3
         jKbw/6aIg3GOfQ7pYTs2bOm5U5YhVIES3w/tRIvYkmzDWSOWUVhbooLQKNzkfpU/Xndh
         oqU+rZ/oTJojSlQVf4EsxjN/2gSFMd6PniR2CbXupYEaCds35INEAEaDR2E7NjTDFw1o
         ISQSNz3ZQ6vE6OYN1fhs4pxF0Vt5LX5psVxRL0nLXIXmittMXNiE0gSI7B9FXGgDnrvy
         7kRgYxpOXVn9CP0WHdB/nDgmifpQkh5ggSXih0JN4I/5V+CmR5BwHkLM/KXKXaddGjkG
         YM5A==
X-Forwarded-Encrypted: i=1; AJvYcCXaxLhCnSKNNsXRPEaP2Q6GbLwH21aA0DVI95cL/YKIaCQ1LO6QUuvteFleX8eyI9iffLV7s4G8LKshSx3pqUorl4S6Y24F
X-Gm-Message-State: AOJu0Yw2CvtlPIq5cH2+/LUr3KC9wwDzycx3JcGLqlGCFM9bmrH1Exk+
	C7B1Py/OyLOQpNgLE69YY6JpMNpCqHsvKxEWPrC3Au0D5cHNHnfLhX56RufbSeY9CSku6vXngmK
	nDg7CtaB/vz0+hwIsfjUXgpQ1Vok0jvSkGzNI
X-Google-Smtp-Source: AGHT+IG578Rj9kNnh4PrH5zfAaDHENqa+qnaPSMyY/rvPtoQe8Civ1QM2VlkhD3BwXWEWKtw0+uj8UT+qSDSSYjqVcE=
X-Received: by 2002:a05:600c:3d90:b0:412:b689:5d88 with SMTP id
 bi16-20020a05600c3d9000b00412b6895d88mr46883wmb.3.1709194252356; Thu, 29 Feb
 2024 00:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48c4d3db-66d5-4a9a-ab9e-9036db7222dc@roeck-us.net>
In-Reply-To: <48c4d3db-66d5-4a9a-ab9e-9036db7222dc@roeck-us.net>
From: David Gow <davidgow@google.com>
Date: Thu, 29 Feb 2024 16:10:38 +0800
Message-ID: <CABVgOSnpOzOr3VuKZc3okhJqf1yvsEe56YPdWn15Ag_RDEZi8Q@mail.gmail.com>
Subject: Re: lock warnings in dev_addr_lists test
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000496c23061280ccc9"

--000000000000496c23061280ccc9
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Feb 2024 at 03:45, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi,
>
> when running the dev_addr_lists unit test with lock debugging enabled,
> I always get the following lockdep warning.
>
> [    7.031327] ====================================
> [    7.031393] WARNING: kunit_try_catch/1886 still has locks held!
> [    7.031478] 6.8.0-rc6-00053-g0fec7343edb5-dirty #1 Tainted: G        W        N
> [    7.031728] ------------------------------------
> [    7.031816] 1 lock held by kunit_try_catch/1886:
> [    7.031896]  #0: ffffffff8ed35008 (rtnl_mutex){+.+.}-{3:3}, at: dev_addr_test_init+0x6a/0x100
>
> Instrumentation shows that dev_addr_test_exit() is called, but only
> after the warning fires.
>
> Is this a problem with kunit tests or a problem with this specific test ?

A bit of both, I think. KUnit test cleanup is not guaranteed to run in
the same thread as the test, so that definitely is triggering lockdep
warnings.

On the other hand, we really should make this particular case work in
KUnit. Ideally test cleanup will happen on the test thread first, and
only fall back to another test if the test thread otherwise aborted.

So, this is probably something we won't be able to fix if the test
fails, but it definitely shouldn't be happening here where it passes.
I'll look into fixing that.

-- David

--000000000000496c23061280ccc9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
7xDrOPfX3COqq162RFg/MFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AK0lDd6/eSh3qHmXaw1YUfIFy07B25BEcTvWgOdla99gF1O7sOsdYaTz/DFkZI5ghjgaPJCovgla
mRMfNcxZCfoBtsB7mAS6iOYjuwFOZxi9cv6jhfiON6b89QWdMaPeDddg/F2Q0bxZ9Z2ZEBxyT34G
wlDp+1p6RAqlDpHifQJW16h5jWIIwYisvm5QyfxQEVc+XH1lt+taSzCfiBT0ZLgjB9Sg+zAo8ys6
5PHxFaT2a5Td/fj5yJ5hRSrqy/nj/hjT14w3/ZdX5uWg+cus6VjiiR/5qGSZRjHt8JoApD6t6/tg
ITv8ZEy6ByumbU23nkHTMOzzQSxczHkT+0q10/MxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAHS+TgZvH/tCq5FcDC0n9IwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIHKIWNTZORH/Li1QuBf3aG+LmVOovF9HyPQ/CwTrUCd0MBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIyOTA4MTA1MlowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBJlI+Z
jUHympxKZN1ihqa0ii3YuzKAa2MkfXu7gprUEE/+ckzHEpHbjoOypLxWNT2+Ogygds4+u8kBO+w6
3sQgvTMc3ejWbmNB1am/0VsfzNaM4LyIe7OyICP9RkSppIVryZPMVT+SpJsNAobGUltnxYARQQHN
fqbUb1aoCAIy/Xn7TEYGoeT9Vqjm7QovhPgUu3RiYjzXY76E5WSdkldnxXWjKOl90D23Yc5o/8yr
TiaDncvug5OmwCsvhxx0xekxXUT2vPG+1sbDv/u3pdjvAJcdUkiks09AZsk8XjVREkl3Q9Q7iMjV
RRVGeKQjQM3nrPF0FDqCK9nhPM0kUQTH
--000000000000496c23061280ccc9--

