Return-Path: <netdev+bounces-213356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7899BB24BA1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE403B63A9
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15B82D73AC;
	Wed, 13 Aug 2025 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9v55Pkn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8981494D9;
	Wed, 13 Aug 2025 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755094121; cv=none; b=bTbpCXzpFf3riNNhEXIPWhWP3mvOrNZqQz15Yto5OK/75UP4IL0lqlFZ1O97ykZLsNwk1LYhOZltpaPmO1HeRxOwS8jwXk0hlE/6/lCdqFwfXagTX3IwkyyZRP13T/Kx88azHk4XAAkgdwC7w45dWC8j+mtVK77alNFtNnOSLLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755094121; c=relaxed/simple;
	bh=TyooeoqAwMEMmIJ2ameYW/470oIl2dMhKY/IcRJSBmI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tJtZa6iqoUliC8qagujTN7NwL/976OI3JumIQx+nVXlMXNEf6HxCFfyCN3gl4BWN/YHK1v77MW/7Hr8z1lJ3IC7OGoqoM8XK0BD2KfaSEEbsUqwbUcqzpP70cHFSXe8U16PM+X3rtITy6NTvw0kVVq1RfH9a6aCww8VSvujMvUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9v55Pkn; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4febcc4c93dso814779137.0;
        Wed, 13 Aug 2025 07:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755094118; x=1755698918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrR2FvKqNjAO8JSf8v0Mfa7E2lvJl/vs2e+uVawU5bQ=;
        b=a9v55Pkn6s6zucEBWMlB5jgOaVqaedZRqNekYwjNbT7JxE6OedyaEV02Ex8zIkzPVK
         +cNPkRCcxgegIeSzTaVfPB5jFpnzp4cJt6hjYc8T8uVQcrmqXRj1a9Z3eO/yUeMEzhUm
         kqmK35EQlqfA5+6SeHyIVLlpTXLSWFnn8d1AAv8XCkFRiPpSGdI5EAJUZoZtiOUO8JO7
         j70eaPiOaFT6UiwoSUF673xyLhd97vA0QsWTIDAkOa+Mw/zN/ePnKCyQ07fwjaYFlbCA
         M1+MRJd1KVZHFj7wfIIw4KxBoJaakwMOYXekqzIi+nUt7ddIOUo4NnEB5pNA19dr7VmT
         I0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755094118; x=1755698918;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RrR2FvKqNjAO8JSf8v0Mfa7E2lvJl/vs2e+uVawU5bQ=;
        b=OWCJnW//YM0OGz3GAeOpZluujCQW8JdjnoPiun9JAQ66OSQqrGNhLPcOnyumcJpKNy
         qGow2/qjjk6E5ctRVSZhv7nGyUSkJW4f5YEgqNLuFZhHtCEQQkfRiZGQhv4SB2HyWzX1
         p8wBg07cv+ertICijivq5aSky1Zo977AsmBTo1Hcl1+M/Km3EIxH91JUmbFp/7Gq2UxY
         z5lXvQkvGF61DZuP+CmR61/S11/7W4KnJmDbFIzYvjp2TzZ/vHIjgQsdhDKWyVkDXrOq
         R1kPop8cRtY5YB7HNLH/P9s3iw9YIbTcdTZYCV4raKBhNh+a544o+HoklGN02A3Jp11B
         TYww==
X-Forwarded-Encrypted: i=1; AJvYcCXbEjdw5939K6UjY6nClPdFUUg2kjoF0cRdsG/ntURvVAoaUw7x1e6GxIHBVqjamUQSdhPAdfi4EtAtd5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrW4c/d/tZBSpIwJ8Z07UivaxKFjm9y3wOEab9etQ3sa/geex3
	1HQDYOIXW2oZN1KT0WDrcElaWQA4JfioeDRU25NSCdscvuzFqS98jEK4
X-Gm-Gg: ASbGncsFaMedwsUmjxuxPyxzbTLFwqUwc+fwdyF3VMkjafPOmdz3MlT4idp9XOAZX4R
	mUhRjU7CQFJ3b/AQ36m6wcgDpIdagaeTMiX3He17cAAo9bO6Bx9mR/euGHTnr/W4sXDBchBP/Ok
	sKJCU5nvR+XjbeKY510u+vAoPZ9vFpRkX3GH6spvZxwJ50+MG/cXTFyviuRQ/rdt1geZA3SvFrC
	8MAxpToUbPW32QuxEIRK+ZrbxYFDrPcpx27q9zyOMOd9gJUdvr4TN5Vm0W3qeRvv9UIgZfGArHd
	B+Zn9tflKhdp41h3FgrxQfy3OQHZwvWtS7IeFBsv7WQIZlg+gRfWJLGxLwBNA207XvDFO3Vw9Sv
	S12QKXJYsJW/5WlrQ7goMkS9x4xZWEDQuKcmKOi/0yQkaROp4DouNJVG4LJR1TtFbKzPoJw==
X-Google-Smtp-Source: AGHT+IF1Up7qX3tRfbS1735QPrVh2AF466vMRmMF9ztobYkUPbxB+SOBtb7fZ4Cxx+/BiRUQsS4zPA==
X-Received: by 2002:a05:6102:3245:20b0:504:d7fc:d970 with SMTP id ada2fe7eead31-50e79d59d41mr629630137.12.1755094117888;
        Wed, 13 Aug 2025 07:08:37 -0700 (PDT)
Received: from localhost (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e85d4f5ff4sm315016685a.3.2025.08.13.07.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 07:08:37 -0700 (PDT)
Date: Wed, 13 Aug 2025 10:08:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TWlndWVsIEdhcmPDrWEgUm9tw6Fu?= <miguelgarciaroman8@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 skhan@linuxfoundation.org
Message-ID: <689c9c64ef692_12a3a92943f@willemb.c.googlers.com.notmuch>
In-Reply-To: <CABKbRoJFtNFic6REpme2MgS-c4SPOXZ-oJF-TAFKK3ihAiRQjA@mail.gmail.com>
References: <20250812082244.60240-1-miguelgarciaroman8@gmail.com>
 <689c8dbe91cf3_125e46294ae@willemb.c.googlers.com.notmuch>
 <CABKbRoJFtNFic6REpme2MgS-c4SPOXZ-oJF-TAFKK3ihAiRQjA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tun: replace strcpy with strscpy for ifr_name
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Miguel Garc=C3=ADa Rom=C3=A1n wrote:
> Thanks Willem. Should I resend with your Reviewed-by tag or will it be
> picked up when applied?

No need. Also see other patches under review, and especially read

https://www.kernel.org/doc/html/next/process/submitting-patches.html

Note the comment on top posting.
 =

> El mi=C3=A9, 13 ago 2025 a las 15:06, Willem de Bruijn
> (<willemdebruijn.kernel@gmail.com>) escribi=C3=B3:
> >
> > Miguel Garc=C3=ADa wrote:
> > > Replace the strcpy() calls that copy the device name into ifr->ifr_=
name
> > > with strscpy() to avoid potential overflows and guarantee NULL term=
ination.
> > >
> > > Destination is ifr->ifr_name (size IFNAMSIZ).
> > >
> > > Tested in QEMU (BusyBox rootfs):
> > >  - Created TUN devices via TUNSETIFF helper
> > >  - Set addresses and brought links up
> > >  - Verified long interface names are safely truncated (IFNAMSIZ-1)
> > >
> > > Signed-off-by: Miguel Garc=C3=ADa <miguelgarciaroman8@gmail.com>
> >
> > Reviewed-by: Willem de Bruijn <willemb@google.com>



