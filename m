Return-Path: <netdev+bounces-232215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D634C02CB1
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 19:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09C1B4F20B9
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5D4322C98;
	Thu, 23 Oct 2025 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQzubiDz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEEA30B519
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241811; cv=none; b=jBrOymqqYJXycoigumA/OaHXZBw0gBmO/DcmWJeV7+7UDYVWHC+5jL0DvBDAXf8sZx1EfwhucepKlLfEg293MGiGxzzLxZ9/aXtAJ5IcqtZln60EHp3/o9Wf3ItZmvqKidjrpu0lOO/CPTI9pi5Cdc2IN1/BiaedQpjbO4yi+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241811; c=relaxed/simple;
	bh=rmrFSVUHVZINnn18mE9h8LqSYST7xKMxaZNupWgxrjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9rZsblk0Ob09isy1d99lQfSMheypaH2P353NErOxzvEL52MgCztVZsZ7k9rSyOEPATTeiqq/tt9Q2llTGErVpHV4pyDvvFzZoHU710qLfLF52ZIQtaXYD6V4jULvTaQ3FGz6VoUDYrSgZ44o/VLJJ7srzaLayqS37mDS4V1V/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQzubiDz; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5db308cddf0so983771137.3
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761241809; x=1761846609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmrFSVUHVZINnn18mE9h8LqSYST7xKMxaZNupWgxrjM=;
        b=JQzubiDzmbNqDV95lZrTIg0yptiLGpTeX6V4I9YJxmaCMp2E0ScVVrmK3VOj33J4gd
         EARbc4fNIgtpmI2H3/h87upSkmLx6YVmyIemn/eXusXQEs/KzvrO1l6h5bFR06A6u7kx
         Xv9nDKoJnfDfsWrhJlY08sVfkhFA/KWz7fna29L0X4dVP9MeQV2coonVBN56DMDpqCN2
         nG2OG/II5c5bMmEPXY+AM1xZc91aHXw0BNcdzrlxuwdxa1Y28ScuHds8rfdX7o6BUIvR
         GTWj5vkcE3fbr9ok/68a3VDU9Zmrsx4R9RNtNqlYW1kiaRmcoGJxTeWwDMNuof9gOTOt
         g87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761241809; x=1761846609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmrFSVUHVZINnn18mE9h8LqSYST7xKMxaZNupWgxrjM=;
        b=DrwmtXQX00PS6atWwNm/5kU6VKzpHvbKCPnwIoS+ZFDXOhxzccpx466/Ed6X4YCyl4
         9HZE5eEfPqnl+VgVbSt16IL5Q7EUxj1kLSNrn6NjBqOvf1//dD3IQzWCsIw/7kumJEUS
         ueTjvAiSMVHthIdmU9o+o9JshcxxV//25ENx1+MuO6hol+Nh88mQYWE1Af+5bySArmk5
         fH/I+YBU2B0UtC3NGKapGAl+32MGmHLVjFRoCxOYo02yE7W7wNHod4vMQsuodqZMY17w
         I8AJH4TcoXzbPgH7/5TwGOZ+l60Cb/aXeYtc5aePwLxqf54Af0FQLqhBG1VhWVPtlR3r
         9Wtw==
X-Forwarded-Encrypted: i=1; AJvYcCUi4jkPVAuQMAi+rpjpsBo6B/eYzTEzfCdfzr7DVSwkCMkXX2tmioDka2oSZgijUxMhZV3z3sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV5443nW+XzmfdKm5HDS2fAoEDyaIVJgEnQwjVqK+zdYuH72vA
	wZ4HKWgf38FPMymMW0LAZF510svqXD8Pxs0O3+Kd4atTBRzL0U4Ytxi3lxmFuen8ombRoK1s5Z2
	vG/M391s1VlL0xf1lJrSVWRTBhnbgz5s=
X-Gm-Gg: ASbGncvq5H4nCesIlgRLxHFpyQFVMlO5K+bw3pCf87s11hOo/xsk+b7G8lRhgm3vIrp
	1FNBXBOCNmyu6AWLVQt8LDYaqjh8ko1lFzdvnUkg8wy2GxFdwmjz1dp3G/bnDPAwD4uQbP3lLx6
	9i1+ltygn+uHOA4emdpPtajaFyG7QViROxa4ldLguvK1w09C8jw1kYTcc8/rPZh5Apl2mq1wwDz
	FkwDL77ce1Bvxa7ztxjsS1tkNnhKyRxOPUtF/7ceacE/+2p1X1Bk/3oZ9WK693X4++k2lG7XLFD
	NeRLGvSdJimXArFBVqEmdlyNiXKHHPdqFOBESjiv
X-Google-Smtp-Source: AGHT+IHpRyuoav5lJWR6O5jHg57c85VAu9Fw0WMge5AnlPcPoxSh3EP98NNnI6EblMA4ody0QL3Q+Pm2+edFZxbqWC8=
X-Received: by 2002:a05:6102:5cc6:b0:5db:28ef:3dfb with SMTP id
 ada2fe7eead31-5db28ef4bb5mr2325429137.34.1761241808691; Thu, 23 Oct 2025
 10:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvbK_c2zqQ76kzPmTovWqpRdN2ad7duHsCs9fW9oVNCLdd-Xw@mail.gmail.com>
 <20251023173801.11428-1-vnranganath.20@gmail.com>
In-Reply-To: <20251023173801.11428-1-vnranganath.20@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 23 Oct 2025 13:49:55 -0400
X-Gm-Features: AWmQ_bkWcF1bKMfuE_JeO2G03ig-UJSmO2Qz1WYBH2Xg-mAv7cSejiDOLi0AucQ
Message-ID: <CADvbK_dJpnjZS_UjoM-D6xRhdhq_uH0FBBbr6tN_7qKih-7zKg@mail.gmail.com>
Subject: Re: [PATCH] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	marcelo.leitner@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 1:38=E2=80=AFPM Ranganath V N <vnranganath.20@gmail=
.com> wrote:
>
> Hi Xin,
>
> Thank you for the feedback and response to the patch.
> I would like to know that above analysis is valid or not.
> And do you want me to test this suggestion with the syzbot?
>
Yes, if it's possible.

