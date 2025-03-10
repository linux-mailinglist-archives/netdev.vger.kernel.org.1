Return-Path: <netdev+bounces-173451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A167A58F40
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 10:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09F21888FBE
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 09:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6342A16F841;
	Mon, 10 Mar 2025 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5Z1TdZ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C632206A4
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598196; cv=none; b=SY65lueuUaYJxLbOzgDr4wt0Z9xG5jsJHQmEA2bUouaTDg84fJYobCypH3TVzAdrI20MIOUESf62GascuaTkCRWVDWhn0+PugQBDdFgL5k79/RMIpKiL0DQUhXVbfHFxIT4crXzmLkMJNk20tchKENxSwY/ijQ4NLIHYLb6PXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598196; c=relaxed/simple;
	bh=ninamqb7vD4VLgKD3iyknjBi9WOPfVs4v5jK2EupO0s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o+AVERAa02KiUspyfdbTqS6l0VZoeH3shmicVXcUs2/sHwG2/54qMqL/hgiXqiorbFjuOs12ysaL+tiIMy0wFDq63aUDjIohf0iUM1rs0gMdksIaQtTrAI3Y59DiK8MI2eIW+3SvZ0PMNDJoxsUF2HoJOKwrTNh2Q7zwgTbUa6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E5Z1TdZ6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff8119b436so4699839a91.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 02:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741598194; x=1742202994; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kg/NOvqEFnXlKsdlRnZXMu1Bj2kZq/dP4ivk4ONGq2c=;
        b=E5Z1TdZ6sj8zMpbxrfYIjdkjZNeY6ju0f1xBeSZz7sLDr0TQ+oMNaLf/ivS+fp+Zx0
         GZQqG5Wrd9eo0InZUJxu4rQlbIlq+35/vkfLd4vo+c4n9yFbS6a0iedL7Boi5Q/4yuGh
         34SQMPy0MI4AcOnkvSUluW0nX4Nl2pm9UsWbBAJHBUzGtC0P8VDyv7JLko/WbxPO725o
         HOa/aN+65h7NR1if5py+j04n9yL1X4tap02ytf8rDdaVwjN3JaIsySfIy0wC4c+sQCJN
         3ZIaj8coucIlePmJtSfVDP6pJPPhKscGYflopLHyxMsYla5apNCWLVDeiNlp0drIRAa9
         Lp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598194; x=1742202994;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kg/NOvqEFnXlKsdlRnZXMu1Bj2kZq/dP4ivk4ONGq2c=;
        b=uOSVhDwm/YI1bkbK5R2XWcJRLFRTNCAs36HeNuQd5gbUe9vzr5Bc4bwteCAkm44erR
         FdPckj6/s4/Cty50N2gJ5pFDB0iUw4QsWR2K32I//1ffZ0L2p+usLqze+fkeAuSIIP/U
         v9cgJeuIAWcPEcLjlFrZBh6aqz3381kw0H8Vn8oA69uNazJ/2jLOdYQqsV0Nx36bNTtK
         fFWubRFpk9ptaVLZXYmd2QMQOdm02tVgMm8ln5zLdSSUNUENHO8IzXccDN341cxMdNyT
         c1FZRS6yxxUx8c91p+J6stfkViQBZRxOI5biCW0Qrmxv83pFLY3YeR2dyITSYroUi61c
         HhlA==
X-Gm-Message-State: AOJu0YyhYb5dwykF1pLfaKw6wIg7dZA1ETDja5LAEtVE/lUbZ/Eu4TrE
	Y2pnNzWXKDjOuxzuDXhxPnzXJHkaopHRc4IeQVHfql6ZYyvBD1nlUdul3uJ8RrFjHoNjmVJXu7G
	DISrA6E6pk9k0ZGR+3THbU3XFy1grySTllJ6nA7KEpPYYAhhBsYNJ/y3rLtbzyiEhvKIeAeBzba
	bps4kJDpKOVc1iosj3EwX14MlMhxQuE6mM1l6g5hEn8qfk/aj8p/2eKTFrkMN7FwKNt9z4rw==
X-Google-Smtp-Source: AGHT+IFynjuWjT34oBjLpxFawgfP/+OMIVN2vHHsSKc7ONoGMM7Bp5t3Af4eORy6oTIG2By83lPohw1zalkbv/6c3c1z
X-Received: from pjbst16.prod.google.com ([2002:a17:90b:1fd0:b0:2fa:26f0:c221])
 (user=chiachangwang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17c3:b0:2ff:4bac:6fba with SMTP id 98e67ed59e1d1-2ff7cf0b067mr20299684a91.24.1741598194026;
 Mon, 10 Mar 2025 02:16:34 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:16:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250310091620.2706700-1-chiachangwang@google.com>
Subject: [PATCH ipsec-next v4 0/2] Update offload configuration with SA
From: Chiachang Wang <chiachangwang@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, leonro@nvidia.com
Cc: chiachangwang@google.com, stanleyjhu@google.com, yumike@google.com
Content-Type: text/plain; charset="UTF-8"

The current Security Association (SA) offload setting
cannot be modified without removing and re-adding the
SA with the new configuration. Although existing netlink
messages allow SA migration, the offload setting will
be removed after migration.

This patchset enhances SA migration to include updating
the offload setting. This is beneficial for devices that
support IPsec session management.

Chiachang Wang (2):
  xfrm: Migrate offload configuration
  xfrm: Refactor migration setup during the cloning process

 include/net/xfrm.h     |  8 ++++++--
 net/key/af_key.c       |  2 +-
 net/xfrm/xfrm_policy.c |  4 ++--
 net/xfrm/xfrm_state.c  | 25 +++++++++++++++++--------
 net/xfrm/xfrm_user.c   | 15 ++++++++++++---
 5 files changed, 38 insertions(+), 16 deletions(-)

---
v3 -> v4:
 - Change the target tree to ipsec-next
 - Rebase commit to adopt updated xfrm_init_state()
 - Remove redundant variable to rely on validiaty of pointer
 - Refactor xfrm_migrate copy into xfrm_state_clone and rename the
   method
v2 -> v3:
 - Update af_key.c to address kbuild error
v1 -> v2:
 - Revert "xfrm: Update offload configuration during SA update"
   change as the patch can be protentially handled in the
   hardware without the change.
 - Address review feedback to correct the logic in the
   xfrm_state_migrate in the migration offload configuration
   change.
 - Revise the commit message for "xfrm: Migrate offload configuration"
--
2.49.0.rc0.332.g42c0ae87b1-goog


