Return-Path: <netdev+bounces-231506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81467BF9ABD
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 04:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C59F19A44CC
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 02:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6C7169AD2;
	Wed, 22 Oct 2025 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpRNFRU8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4D4350A15
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761098601; cv=none; b=N84o9dzN7mHQdHTt4ai2xilyeYtU9jrD9TqI5utCUkeEDs23wQ9v6rSZykbi0ej8I7vrhbRY+8HIjQtbiyWxoL0rPjUhLarhP4V9d9hwh6On5VZJAq9871TZm+tEbjaaioHCR+Eyk0EO8gUA+6mhhA74ttdLguX9Rzcn+IRroqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761098601; c=relaxed/simple;
	bh=cx0xb2tspvcATfWAf76M1i6bjL3wGY0Wf1jEDZamSn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MahnBRPo20L8e/6VumqldSskxXpjY7LBlRjeoXV9HUzPdkFl+lR110F8ofxhOtY8hg7qTvznME40DUyS1izw9pdBJeCFaWNSWCnEEPHXgKSmfhsTvcKRs+UQ0IqTQYG41IrWwBUCaAHQ8mwi59AexYPh260xQRb73ZwDhWFUPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpRNFRU8; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c29466eabaso1207604a34.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 19:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761098599; x=1761703399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx0xb2tspvcATfWAf76M1i6bjL3wGY0Wf1jEDZamSn8=;
        b=CpRNFRU8w/ZOCqTC7HM6x0+uuKWw5fhEDRISOnTrZ1vyCnIDdWS9GGucwOZjNlr8d1
         IUAeMPO6/SQmEoDsjM1mm+0OsHOcbJ2b92rP8+RXwrSwUQlfqeBX0fBv+7Tj//7Q/DzN
         fh5lha+9VZMlp9hH523yDSgVtCHuzyoaobAhOL+5rCFX7g8rwm9pV7oPMaeF0aEXF4Xl
         KH8MkA1zD7jC25sh8AYpNoy/VT+E+k1e0TLIs7bnGrlRhD+/10lpj76xr1X53ndqyGqJ
         daDTR+pE1TtVFO7moMgNNasZ8bdpK3DKaXFUSX7H2ZsLnRIAvbBLLBOhSdtZ2I34KXiM
         /EyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761098599; x=1761703399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cx0xb2tspvcATfWAf76M1i6bjL3wGY0Wf1jEDZamSn8=;
        b=kSOUdx/0RpLfUliA5rqTWXP7drra7J13lq7D8Z0un7M8kq0vEdjvnRTFwuwuyJAKJB
         R7W0hV2KyD5DUAV1/4Z3YS3Pfzcx0etA0I/DeS3CM4WEO08J9z4MYaQDz+2ODJPvYpUN
         Qo7Boq9caMb7Jd/1z9G3PytvjWzW9/GMGSfHgaUfP99xxsgNz7J3GMrAxufbhlEkZy0Z
         ia4unJIMabxcKeMY3/3kqUo3RFQBpVxiPEm5Xljr4ivnyTyMTDW1o1pkA67rGa85wM4x
         mqZ2H8m83jgL3zYvGEscm3dMtIoICgMGLtY5vfPe/mgWq8ngzhzbpFO87j01dynMX/Ff
         PfUw==
X-Gm-Message-State: AOJu0Ywq9Y72R4MTVb4j7n6Pqpoy96U2+eDOrzZIRxmE6DrhvgFW7/Ek
	E/1Pb9P3IXrk6jEAEhFoniS7Twia8TqmKKbkWoXdvPS7kTcESASOXbeRW24xSRK+S15OeoQbstO
	qgql8IpvYBeGtvlQ1cBQ4yXi0PCp41Cyz1eg3xC1Z6g==
X-Gm-Gg: ASbGncvtqKePqC3OqCiy9rLd0WGSwM6F5fGA4Rm44QQvTl/TLUmt4NEnSH9mvCUdfex
	GCZoWkFYbYqHWitr76DFPzKmDXfP6dBjLITfZtsLMPYeBEGmevIUnJnTWCHkXX3p5D61rVO2gBf
	7FzSmKF0K7LWLg+px4OCi175dosYb0/y2o2JCo55bUMgCZoZM8B6TSuo7Ibl9VPW1Vqjzmv9vnt
	/vIvsXC/1nclLJTmHAOGuZSSNs14NIHKTf4BukhcooktRvOr+W4RNRd2DueMbrT6GGfs8tq+xXC
	HoKeDxw=
X-Google-Smtp-Source: AGHT+IGPMAMqW+ehjY5vsk5uTZyata3Roj0lKjejzyNYq6v6JkAiJ8THnMqRcjqw+eJAPUKyBxmUZ7sD2z9F6w1rf6g=
X-Received: by 2002:a05:6830:4901:b0:7ae:39a2:2656 with SMTP id
 46e09a7af769-7c27cc82201mr9521432a34.25.1761098599077; Tue, 21 Oct 2025
 19:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021135913.5253-1-alessandro.d@gmail.com> <CAL+tcoDqq6iCbFEgezXf69a0inV+cR3S5AVEPi0o18O-eJNHXA@mail.gmail.com>
 <CANp2VBUo_8dXjjFLmgyP=Wtz65-F_BQ05Bfrz3xB7cs0iW_CyQ@mail.gmail.com>
In-Reply-To: <CANp2VBUo_8dXjjFLmgyP=Wtz65-F_BQ05Bfrz3xB7cs0iW_CyQ@mail.gmail.com>
From: Alessandro Decina <alessandro.d@gmail.com>
Date: Wed, 22 Oct 2025 09:03:07 +0700
X-Gm-Features: AS18NWCEbKKzgMsjm3kzUjpHEo27CMmvWG6K91ejZVKGn2oB5GCX7FvG4Roa6ro
Message-ID: <CANp2VBVcu50OH0F4n7fDyWWfg5y_kuR954JrEKkMBsV+0KD4yg@mail.gmail.com>
Subject: Re: [PATCH net] i40e: xsk: advance next_to_clean on status descriptors
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:59=E2=80=AFAM Alessandro Decina
<alessandro.d@gmail.com> wrote:
>
> On Wed, Oct 22, 2025 at 8:16=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hi Alessandro,
>
> Hi Jason, thanks for the quick review!

Also please note that there's a new version of the patch so I guess we
should continue
the review there
https://lore.kernel.org/netdev/20251021173200.7908-1-alessandro.d@gmail.com=
/T/#t

