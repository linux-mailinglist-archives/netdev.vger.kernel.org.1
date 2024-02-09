Return-Path: <netdev+bounces-70478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C7484F288
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E841C24200
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 09:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ACE67E6E;
	Fri,  9 Feb 2024 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1va/iMPU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD7467C5B
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472059; cv=none; b=bn06zwe/xoQ42yN6NUOiaph+reo+H/zs1Bl4z6I+QVD495LtAbLYRaymNLISm/0UmsrwddrLI7LJFHGTC3NA1v5WT8K9diAjthQZhYkE0eCVW66fKYC6CifsDQmuhFrfXd44H8CnYRJHZXdVoec41WOruQI0JDWyXMTXTwjh5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472059; c=relaxed/simple;
	bh=JGazZxmRKDV84NmOpcjeIU/ahnty4P4fiAZyie0Cwnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZBvk1Svg+UHpiIuLj/ocw+RmkkMInMTEKz0MuFOeLC5Kzbg+muK5XM4B6fI8lyfRMzbeoebhdm8uyUHbppTmv2x1u5T8jndoWjQhEJ8UAXN3xu48RJnwMim+5RHZDdiDAu75cc/6Gg5yd6TCd+PR2WVLexUDMYyNsJpWrkjKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1va/iMPU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so24015a12.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 01:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707472056; x=1708076856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGazZxmRKDV84NmOpcjeIU/ahnty4P4fiAZyie0Cwnc=;
        b=1va/iMPUuSOSnXiXAcDkvRrJKU7BdnR6ZPevehBWOHoQFfDZ749KXSPX+xNratdLQF
         F65KG5iCcLiUDHAquTUlxCIXvR1Vv+GP2dGCc9gxCj9UTC+pbZ2OnObsZJ86VHKxnnl2
         ZAcE9j/DyOjTL4YKpoUalgQXNfaU7U1cxdFBic8GSvLLJPH/6ti5PXcULqQNMrJ+FgVu
         tq46Vv5R8E7jsQWju0lVRnsMZQzaCjS/GQpjJ4faIx+XPSJbHOESGdl0J8fAuX6G3F6q
         LpoC/F3gWoY5BqF8hgg663n/TXwQHS5sSDHBtPrUzgbJq38WSqvCVZDCEiDyaMsQMEyZ
         zRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707472056; x=1708076856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGazZxmRKDV84NmOpcjeIU/ahnty4P4fiAZyie0Cwnc=;
        b=t68vsACIJ15lpbEutydbTxkpKJuH8Fhwrrm2kqk0wnTGwmDNR59Nr1sQ3VAXcl3fav
         w3tclRxF7ckZma5Z5OoYH9rtTWu9grbmRethUl3cYoUEhORupEqQVtgHlgopHlSQbAh9
         aDA382Si2ECmd9FGJCGKtJ4by1Ovbx8w8dpP8Hd5KSUI+BtHV69gZUKfmCMKJzTm7gm2
         SSGQxXRlY2rToYBdIv/aCCWTtrnTEXKSBDRsDuwnMoGeeA0faD7WcrOJeQte8iiC0J8i
         YpHTJKUl9kOUPbofORebnfvfHDy7/unthGmMJ1DBWKAgY6HU+o/rgQEsVcJfxUbZ4Aoy
         6NaQ==
X-Gm-Message-State: AOJu0Yz5YROWLFDvJ+Fr0vN/A4mqy4peHBh5hB2wVbygO/wMXl/MAGW1
	fySY0cQUi04/sRsPdnj6vtgJOme0vziA2zqVVATDDGEW07JmzMrwjdnMZOPdPKZHUYoXVC0I7A2
	fS8BcpPrHWn5fAFWgYspxo2hjYHIqpZyToayj
X-Google-Smtp-Source: AGHT+IEJzkD4kRpOtBq6NgofG982NoJBOUPWChnSDk8p3iDXf40TPun5R3qVTqpT4siLyN1UGMmOtEqmpq3eJKiisqs=
X-Received: by 2002:a50:9ea6:0:b0:560:1a1:eb8d with SMTP id
 a35-20020a509ea6000000b0056001a1eb8dmr94214edf.7.1707472055544; Fri, 09 Feb
 2024 01:47:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207011824.2609030-1-kuba@kernel.org> <20240207011824.2609030-3-kuba@kernel.org>
In-Reply-To: <20240207011824.2609030-3-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 9 Feb 2024 10:47:21 +0100
Message-ID: <CANn89iKzJVEsO75JjjfMv4oMtA2ieStr3pLk_qjUjKJF0vrUqg@mail.gmail.com>
Subject: Re: [PATCH net 2/7] tls: fix race between async notify and socket close
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, vadim.fedorenko@linux.dev, valis <sec@valis.email>, 
	borisp@nvidia.com, john.fastabend@gmail.com, vinay.yadav@chelsio.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 2:19=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> The submitting thread (one which called recvmsg/sendmsg)
> may exit as soon as the async crypto handler calls complete()
> so any code past that point risks touching already freed data.
>
> Try to avoid the locking and extra flags altogether.
> Have the main thread hold an extra reference, this way
> we can depend solely on the atomic ref counter for
> synchronization.
>
> Don't futz with reiniting the completion, either, we are now
> tightly controlling when completion fires.
>
> Reported-by: valis <sec@valis.email>
> Fixes: 0cada33241d9 ("net/tls: fix race condition causing kernel panic")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: borisp@nvidia.com
> CC: john.fastabend@gmail.com
> CC: vinay.yadav@chelsio.com

Thanks Jakub, this looks much nicer indeed.

Reviewed-by: Eric Dumazet <edumazet@google.com>

