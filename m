Return-Path: <netdev+bounces-144021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6A89C5227
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210CC1F23507
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E31820E021;
	Tue, 12 Nov 2024 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0nHnUxR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E014D20DD72;
	Tue, 12 Nov 2024 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404120; cv=none; b=bN5YICvHSQAG/7IJSBiVN2tPG9G+F2gibgl3rdyLepxuOSfe6JyNu27gy92shxR9zNSmeH7frRLMU6DZUGifZ2q4iiFNS9Tw16hbIUGDE3sqkEiGce/uN52PdayKVCgX5DxhjFnKHnb/HUfsM+8XZQle+b4kqtaoyGM4qPSnXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404120; c=relaxed/simple;
	bh=bI9jM4fM/qrZMNswUV8/w2E5EoB21/DlDLMUd7obgKs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ZkudZLcrDCUgrs/FmplgHUeGzUVRxN23vPEAwLMojVFm62MjjGwASKq2QY6hw+21yE0vDoy6EeCh0AGN9ui0PA7A8BzJGlrOlBT7G9J5Fq0Lrf94r8xBlCTBFJZ6QeRLUumB9EV7q7W4o32rqBGZX0weHHU+klQ67KRSWRdKLnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0nHnUxR; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e7e73740so5040521e87.3;
        Tue, 12 Nov 2024 01:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731404117; x=1732008917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QwUs+aMkdkwpkiVWNCOrQgRTu0W2Xnb6aJtMbSxwnYg=;
        b=R0nHnUxRZ3FciysD/BZetXxiw4ulpdP/7E8MrEDLNpOoVs4XlvIEqxaWeyI3bCsCvK
         eC9aXRSizCiP8uouAlkGwX1RtISuGkC+S3BPJCCp234Mr+SCSUyZrZT8ONi+HDiynzHp
         qBMFrO7b+x3zc2Fo6mJ197htvQkzM5+nlnRc+h+qBWLmjmJ5UNJAC2XRPJt5LTR/ILoU
         55FTx8L4QEtEwolQgKDXPq8oUI+53MzL+Jy+bSlgJ9ItU9ml3PAs9cDNJjrPdJOHX5t+
         KSZIefFEur9pQUDdYOWggyeWM5qa9chLdazP+YfAwSsE1vDu+tMf8ViweIIvBFjNlcbr
         q4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731404117; x=1732008917;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QwUs+aMkdkwpkiVWNCOrQgRTu0W2Xnb6aJtMbSxwnYg=;
        b=eqXA3v5lftXtTaKPMurATaCYRlrnEgwB+mIM++xMwY/GSFLEVLap+99R+j0kJq5pWi
         RkSve62h8xOsUQsX31D45V4ZujMFDuGxzaW1HkBhR2tsYwntbtxh9fSUOz72sEbGkiO3
         +lOjr885eMltoOIa0XZPgev6cpU8cYWjJz8U7tFPzNo4Rh1QoQtNx+Qd7Pk0ezdZa2DS
         Od83MgIOfyDdicYHxlGYcadFWwe61LZWdM1gTzWFyrlB3ct7ZoAyEx1EM43H7kcWEumc
         f/AtZesUKYi70jNtcPj22EghDRfy4/8SKq6dSZDNllPukDciQklfNoFfm7p4VZcy9brj
         gCKA==
X-Forwarded-Encrypted: i=1; AJvYcCV/B0GP+QAozs/eYQb09IWsL+rDyvNRC7eqSC+tQKQGQTKoDx+TSPJmpK2Zcv2D6f9MpX6faw4c@vger.kernel.org, AJvYcCWnepKflc2y/1ZGxLnNMshM+hsCCQU5bz7ZpwexaYRnyfcbhjKOyuMFeqm2RTHyHDSFZPpVLSpYrIhWAqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDIcD4Pvj9maIttrBwcmwXCQh3dSa+tnr0D6GS7fR5IH9sJfiO
	TFfEWBQxCvmIJ5MHrmdebUmh02eBC+2XFGyi88AHjnvJ/a8zDbBaErKcxw==
X-Google-Smtp-Source: AGHT+IGVkROvgPTuaXcye6PfO0q+/Im+e2txwVXXStZ+KU27XlkGrkShXQKuD4JasR3jJVcGh3tfbw==
X-Received: by 2002:a05:6512:280c:b0:539:d428:fbf2 with SMTP id 2adb3069b0e04-53d9a40b5c5mr1127524e87.13.1731404116336;
        Tue, 12 Nov 2024 01:35:16 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:a1ef:92f5:9114:b131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97075fsm14744416f8f.14.2024.11.12.01.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 01:35:15 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  pabeni@redhat.com,
  davem@davemloft.net,  edumazet@google.com,  horms@kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tools: ynl: two patches to ease building with rpmbuild
In-Reply-To: <CAASaF6zsC59x-wCRKNmdPEB7NOwtqLf6=AgJ-UO1xFYxCG11gQ@mail.gmail.com>
	(Jan Stancek's message of "Tue, 12 Nov 2024 09:16:07 +0100")
Date: Tue, 12 Nov 2024 09:26:57 +0000
Message-ID: <m2wmh8u7j2.fsf@gmail.com>
References: <cover.1730976866.git.jstancek@redhat.com>
	<20241111155246.17aa0199@kernel.org>
	<CAASaF6zsC59x-wCRKNmdPEB7NOwtqLf6=AgJ-UO1xFYxCG11gQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jan Stancek <jstancek@redhat.com> writes:

> On Tue, Nov 12, 2024 at 12:52=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
>>
>> One thing I keep thinking about, maybe you already read this, is to
>> add  some sort of spec search path and install the specs under /usr.
>> So the user can simply say --family X on the CLI without specifying
>> the fs full path to the YAML file. Would you be willing to send a patch
>> for this?
>
> I can look at adding--family option (atm. for running ynl in-tree).
>
> One thing I wasn't sure about (due to lacking install target) was whether
> you intend to run ynl always from linux tree.
>
> If you're open to adding 'install' target, I think that should be somethi=
ng
> to look at as well. It would make packaging less fragile, as I'm currently
> handling all that on spec side.

Hi Jan,

I am happy to work with you on adding an install target, plus some other
UX improvements like --family.

Thanks,
Donald.

