Return-Path: <netdev+bounces-63550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F98582DE22
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 18:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C90E1F2289E
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 17:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E079F17C63;
	Mon, 15 Jan 2024 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="C0QfTMmo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632917C61
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3f29fea66so49155645ad.3
        for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 09:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1705338351; x=1705943151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dFiktk11TJEZqPAEmrKV1n2sq63GtsFgFs5yp66KSQ=;
        b=C0QfTMmo+ubqFGXqt6jFOt5vrWkI+paSpMJr0DLjLWPV9McFKW4OylPLhfpeqimdC2
         E84CeMaigiLclc/Kiq2wKZh06GO280e+N8ud2QEwDue2amJuA+2ZwMJDAze4eIG4zi7T
         Dd3SqmFcSk0CLTZejtpC99jB56nuKFo/4bnLtxS36gpeyX7b8kDjEZCG7Z9ygaM7vnGv
         KprOGDOes4ZVgP0OpnaBA1wH25cMsDjTbwDZiJqg4uq9JxqJwxgvx+ocsZPhPGOyqr07
         6pggniYEZXn2vWukwOoCNScBH5yxIV9UcGOm3Cjh1467Iwpq7rhDT0vhuxtX73wiKGWY
         VDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705338351; x=1705943151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dFiktk11TJEZqPAEmrKV1n2sq63GtsFgFs5yp66KSQ=;
        b=NK9WUnUagnGB2V3chE+yHORhcTA8AAq9VaeB9J2Zcy6TkC3aBXvhfABa//R2Ro9nsi
         oO3zQkQnv5yxuNmQ5KpKEadS9nK63MP6IU+/IYggVdvBct3KbX0bAF76eZkduKSx0PYV
         XCQ187qa6bkuj5fnEjtTswWB4S7fb/9hZqXuqZabXJyKTH31JqIWWmpsuyzJ29lAppGe
         JnWWn2CmTciJLPEpk2DpGwvvg90dIWjiq3Yi5lKSPa9BGehgfji6OSkTZsjIPUleIKCX
         JEy1KDRuPbDUHwbg5epSaWrEDXQqzufd1PgDG+cDVY5mLLSuWqADraqDAa6cBSD9Syjb
         zFfg==
X-Gm-Message-State: AOJu0Yxuuqd2mzVvi14ZJWPDVzEzDMK/MHsfi0+SvUb7hECj9ChYegIL
	ThlE3bq6OxNlAJTHt6e0ZDVSYS7NeTOPfg==
X-Google-Smtp-Source: AGHT+IGOxVEKBanujs+tFEQ5mXii+O6Rj1e/nKfr+4O2DEU0OyjuBcNg3/42cX9JY4OcLi0YT1cHUA==
X-Received: by 2002:a17:903:181:b0:1d4:e23e:ea9b with SMTP id z1-20020a170903018100b001d4e23eea9bmr3663846plg.58.1705338350857;
        Mon, 15 Jan 2024 09:05:50 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id ix15-20020a170902f80f00b001d5947f5163sm7541445plb.59.2024.01.15.09.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 09:05:50 -0800 (PST)
Date: Mon, 15 Jan 2024 09:05:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Quentin Deslandes <qde@naccy.de>, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] Revert "ss: prevent "Process" column from
 being printed unless requested"
Message-ID: <20240115090548.04eb7f6f@hermes.local>
In-Reply-To: <694cc41a-59fd-4b13-a6fe-59782beef373@kernel.org>
References: <20240113165458.22935-1-stephen@networkplumber.org>
	<694cc41a-59fd-4b13-a6fe-59782beef373@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jan 2024 12:27:23 +0100
Matthieu Baerts <matttbe@kernel.org> wrote:

> Hi Stephen,
> 
> On 13/01/2024 17:54, Stephen Hemminger wrote:
> > This reverts commit 1607bf531fd2f984438d227ea97312df80e7cf56.
> > 
> > This commit is being reverted because it breaks output of tcp info.  
> 
> Thank you for having reverted this commit to solve the issue.
> 
> It looks like it breaks more than just TCP info output, please see [1].
> Because of the impact this issue seems to have, do you think it could be
> possible to have a v6.7.1 version including this revert patch or the fix
> from [1]?


Sorry, no this is not a big enough issue for a release.

