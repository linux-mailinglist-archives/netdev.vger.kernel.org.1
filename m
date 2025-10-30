Return-Path: <netdev+bounces-234504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6099C2228D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 21:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72553B103D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 20:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813B837FC7B;
	Thu, 30 Oct 2025 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fQ90W3Rr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4890C37FC7F
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855020; cv=none; b=uvCZpBmeP/6nZuKDPtZ8CXgfhz5FmP0PIWsf7ZYuuWZAZU83vyuEATWcMVJ4dP37xm5nWoHafyNRnocDBu4F5zdy9zUqXTW+Fyn7YM6I4JPvtvD19MH67FcC4F0tvEuSpRyhPtRPGJ0yaXeOMQnKeuJKkfAbDJeu9OjRhBo61+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855020; c=relaxed/simple;
	bh=kGGGOwcWE42fYGAACjzzsxoC/wtWqU7BZhAJHfBfsZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmBG5WizsA021QbOY9pFRtffFwNMU5fXzFCzOfUZflxEAyqJmySSug/DmynC8aY9YFBsx6GJsMB68fFV+o3l7FvVvca6arL2x38VZYNT0oCB1GlJ0JCZjiYmFKRtMB8wcEYYuTwUazyjQifk4aRZ7FA58nBs2kBhLXgUZpvJoXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fQ90W3Rr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4298b49f103so611120f8f.2
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 13:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761855016; x=1762459816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzLdDijZwpSIoW2A15EW0OfNrXa24XJ6fVmRnXXjgdQ=;
        b=fQ90W3RrEAhbKaYBvWjckL38Tc5pd5UmqKmQ3KUP4qxlY+9/YambUjVFDeteEqxYgd
         w2d5JUnPI/a+ZTnEJFUzb1ysY4k7JLjSC1QY6J6+b57uPzG+PhK49gOZlOLeC7ABscDe
         NVd7HWb3FqRtf89y2dNq8427n9J+cA2xvm4JfVpAfoM4uJ14LWjrMyaiZiJcXqzmvUl+
         CwcEazH52KbxTuAzgXMT165xwTI9TM4noGbkjJF6yMprYsknqCGMQQdTFKNwJEYhmUNy
         mKN66XKgI3ye9nmE6G1u/ce19Bd7DNwYrrRUvGwOFxLzWhAG2/H2kHy/oZiDs1Wq9Deb
         0xKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761855017; x=1762459817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzLdDijZwpSIoW2A15EW0OfNrXa24XJ6fVmRnXXjgdQ=;
        b=OHT1LZIUc0fOuH5aUB7y1j/n1LG9XYQ8zaPwwXqlKwDu+N/iIKCfoPOHHuoFFS9946
         SP31+yWkVXHg9SfFt+T2Z1wQPEL4mCBdmtNWnD07ik7VIQIckbRdovUb40LFpqGVX26p
         8fyl+eDuFpuvZJDEmmiILun8IyYsim+GMrrVjDodtwlK8/UqVxQhmIS4A4O2NV7nfaBl
         BnrUUiYFCnv5MjjmnlXjcj/U1ptWDUheEKFsuyV/5HzOD/NtSanXes8I/57viDcyGqU6
         bddvFwoz536bj52Ou5UhN5DNby4aqB1P8r/ifUITkkEib7YMUwFGrsRF9HE1IvkrXXAg
         fszw==
X-Forwarded-Encrypted: i=1; AJvYcCW9VBsVeVnw0dcjwQ4kFyib6gJJLG1xQXYYVsFiZUPw4RFprqQ6qocEXqJIxInkCrLrHaY8icE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCwL70AGRHISBZ+t7Tik+uE7j9H8sv8EuoKJFzAs+jCO0Vcs2S
	zrKFVEWUi2KKfoRocfckSs2VlP4hy1DLUz37QPZ6n3WDpxTPquZ8qPi2wtauSFbnfBA=
X-Gm-Gg: ASbGncuw53CRpPRVCbpP65ZGM43Tnk9ZGnFK0PhGoH7PVs0aLn1iNLUPeHAZAoXnFB6
	e21DF/rpn7Lbhut/y7iwdam15IeqxoY0TFnIgTyiDv+WiCEB8l4R6+AKaHiFs2AnFlOruVqdw79
	Es8jhR3MVSUvl3Tz87ZAmTuATG8bfAWtO/uJKSi45qtx3KseGFE9QDbDJfwcyp65BDORYyonGuA
	frlttYooip+PQvofMwi0RIJZQT6xVMSrNzsOCHF7wp/H/MXkWtOb+k9pUqNDMPz6tNWLc08/IRJ
	1kUM9+CIZ78XA+U5IJIea/l8GNx6VIJe3DP7G8VeViVBCle9dFuTKQtmAd16Q2Rnfr1YpkbhOYk
	8E49ubjeGFCQKW1HFEeYAKgSmObSxQLyEUjDQ6Sw5biyBIw8h50mE/EsD+/Ups1IYtmsgdM5VCK
	R7z6KsitJwK7zFccIThHO95RwTr97SVNPcVQQF
X-Google-Smtp-Source: AGHT+IHQ9ol0RGmHEqv2PQoZBv9+EYzaPo/Ro+UlVLhtoS+p6v0TwwFqFdNCX/59EWTX2uMExCo6mA==
X-Received: by 2002:a5d:5f55:0:b0:429:b9a2:bff3 with SMTP id ffacd0b85a97d-429bd6ae187mr725834f8f.52.1761855016568;
        Thu, 30 Oct 2025 13:10:16 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429952df3c7sm33202735f8f.40.2025.10.30.13.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 13:10:16 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: gal@nvidia.com
Cc: adailey@purestorage.com,
	ashishk@purestorage.com,
	kuba@kernel.org,
	mattc@purestorage.com,
	mbloch@nvidia.com,
	msaggi@purestorage.com,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com
Subject: Re: [PATCH 1/1] net/mlx5: query_mcia_reg fail logging at debug severity
Date: Thu, 30 Oct 2025 14:09:42 -0600
Message-ID: <20251030200942.38659-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <8a7ecc3f-32c8-42fb-b814-9bb12d53e29b@nvidia.com>
References: <8a7ecc3f-32c8-42fb-b814-9bb12d53e29b@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 30 Oct 2025 16:48:54, Gal Pressman wrote:
> I asked before, maybe these automatic tools that keep querying the
> module continue to do so because of the success return code, and that
> will be resolved soon?

I went and ran the command on a port with no module and agree that it does
return zero. 

It doesn't solve the problem for me... Part of the reason automation will
periodically run the command is for inventory purposes. We want to roughly
know when a module was installed or removed. Then, as far as I can tell the
only way to know if a module is installed is by running this command which
has the consequence of generating log spam when there is not a module installed.

> Changing the log level makes things more difficult, as most production
> servers will not enable the debug print, and the logs would be harder to
> analyze.

I care less about the logging level... I suspect it should be info or dbg, but
we just don't want log lines generated when we're trying to figure out if some
module is installed.

Cheers!
-Matt


