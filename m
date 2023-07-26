Return-Path: <netdev+bounces-21483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDA6763B02
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E1228136F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD64253B3;
	Wed, 26 Jul 2023 15:27:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5CECA63
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:27:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27DACE;
	Wed, 26 Jul 2023 08:20:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctloqUmKZjONw8I/kdEaJdwW8xXPLCSmXXZQc/L3iNKo/F47eDTiY6Vg0Q2+SIL8zQKERVJB12uAhYIQHs/chOaR6LGDoFhBBVb2wSAgDOVl3CvtKcapNIk0ymWVMEQNdMOnSPndle+ubjHk03/rYXn+Ts4IW7OCGN3NFEs7DDaAmT/679SH/LFxv5+XC3UUj2Z2IXdaIvtNkNELF10KVVOuFsEK5xLCZaSb2RVrccR7FT78/LUYCu9poG0+PZ+fG7s7KWFhHlLWzZAQgRClspyDhG5kiD3fFv1FNbVb4ihxDLnTzD2Vg9wkOd4DVjRZeE924ppG4nmQQ+mmcG8BDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxNHxYU2SlfBYw4f7WB4MW0pdApRH5IqkT4JoSm5qKg=;
 b=Wd7dLWOgR8QsgjU//41UQSrB4M59nMP25BrbgSCy35YhB2Dnu1yxmUXP/msbKb8ALLytBkMWUyQG4QAEt5Mtejib14LZdOrjt512TXoprn3F9TdFbaY7kIBcx9a48frbRYzEQ1hJY53gTmmKqMTKMTcFoi59NzlocrG2S/1R7sQXfMHPtbHjoK7Xefvg6x6jnLz2WuuoFajpMF3hYACsdICyRaV+bJaq8UQNPdo8eDOPQ/IQQl0hs+VOE5H71138uWTlDnXx1gyFlsXPYrJ+nhLZ2iUueJy6fdQ0qjFvhl+o6ULmipwb3NmoViSecGtwG9UdUxzyvOwK+Ux8Z5w5mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxNHxYU2SlfBYw4f7WB4MW0pdApRH5IqkT4JoSm5qKg=;
 b=Dnu1lpZ6Jo6IQbE21oJ6P5zlJdiWwblz4Us+DitoRRAlirU0fxCfhmiiXyM4YKK0gRdBJDMMSXlhbDgsF/UBQZfJAvVeLD9NhS/b1+oc+JdlJIwS0W4lA6Ojl5/5jc+f6DXsjZ+DGGtsvcNMxrzxJ4I1U4rbs4p/QMTVKup5c3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 15:20:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 15:20:18 +0000
Message-ID: <ccbe3ab2-7fb0-3ce3-6054-77e0dc365b84@amd.com>
Date: Wed, 26 Jul 2023 10:20:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from using
 file paths
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, joe@perches.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 geert@linux-m68k.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org
References: <20230726151515.1650519-1-kuba@kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230726151515.1650519-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0127.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 38f5ed46-e27c-4aa9-af93-08db8debd1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QoAOrgXQIJt9KxaQC71uDCTQii83XKPxyAg7AkIkqKV3EN1lUlWIZ/LMjs0wbOz48XoSyEsHmNnpwdEaNADYD+Ga8zzlHzkmdJJVi+Q7lhmXy76wA66sN4ZRjJF79EoRxl/RMC2sy4Yq4Nbbnm69PxxJj6rLaKmK/bpEA/jqg1oKhdX/NA+9XBJ6iVoUHTecES+P3DKkgLyrtYONoZBcNmX+z4NYtjBNp46GQpXoS4C04V1yV3tfTe+9Czoow5ohpaBINhfAgKxAuHq5zvDXxEqSSDGiLMAcRqynKHlokdIVltq8rx5ksw07RHFQ1vuhoivLA+9JVY0PWKQvOO2EuZomC17FEvfNCmyX/1Ye8KZG+Se84SUSt/JO6jOhKF1ISX60DrxEYNutKeAY2RGleFsdUmWEISLzVoJcV101qg9j+2zVaxraPV0cTfIIuNt9Y8tpJ8FqC4kpCzba1KgJJpEav9cKDAL5fTmLv3sFgqoNtlLycu11IO6WG12+fPEYaiGnYdVQAT0JHYRlCeGI/U8Nhm9tp0A2d8Rp+L6IwPaTd51g1Wwqiu23UNwz8G7a2uboIBGpsfEDG6PlAYM3Y37IVHjYFIaBqZ/nZQ7/kkFOAnF60RvCXgMhaLyr4vncf56vqUVd5SH9NCIJnP0vDg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(478600001)(31696002)(38100700002)(86362001)(4326008)(316002)(66476007)(66556008)(66946007)(6506007)(186003)(966005)(6512007)(6486002)(53546011)(44832011)(5660300002)(8676002)(8936002)(41300700001)(2906002)(2616005)(36756003)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW4wSGJpOC9oeDVDODhZcWd4NVZMYURUZ3NzcDFTdVFkVWc2U0xmNU93MjB3?=
 =?utf-8?B?YmZmcWRiWjZwaDE2emxUS0dTWnplbXRCeS90N0tJT0ZuODVxcDhVVlhWcTh1?=
 =?utf-8?B?ekFxNU5WODIyc0NYS2VBRDRlUDJBbHl0dGFFVVFhSHlqeWFSemJUNW9ZMTdC?=
 =?utf-8?B?ZmpDMjFkVDVTQ1Zud0toQklNc1pEVUxyamVDckpONHJRT0xqRnpBSFdkeWxu?=
 =?utf-8?B?REhnZlZtdnFjZnFPZ3ZWNE9CYlJvZDgwTWNoOXJJWUlXOUxORm91YzhCTVBJ?=
 =?utf-8?B?cTJ4cGNaNUFkc0N6WE9qOTdHTXFKeEtndUgxazhsZDU3Z21aMzB2eHpqaHBY?=
 =?utf-8?B?dW1GTEliYVVHNDAweElkT1FPWVdGVzl0WEhSZnMzaDJsampuR2xBcTd2enYr?=
 =?utf-8?B?ZC9FMWZSaGwxZnpGY2U0dFZMclFQZE54LzZYWHhoM1ZNRXJ1eDFIdFBYV2Ez?=
 =?utf-8?B?M0VsOXorWHVqVGd5U2Z5bGNVbDV3dWJhZ2lVNlB6N0EvZExHNGdRNmQwUEFu?=
 =?utf-8?B?VFdEVVhiSklueGE1SDlaSWN5SjVpRVR3MThGKzNTSDlHY0tsSkljTjBDMmZ1?=
 =?utf-8?B?RGRrT0FNRnJ1Q2hKK09QejdQZmtmUkxtQzhRL1ZoZkNRNVR0YXVZaXMrWXF4?=
 =?utf-8?B?YThLejBFaDE1TWFKQjRPWDNKZzRDajZRZ0ZOdUZYTVUwczQ5Q3FFdDEvWjRH?=
 =?utf-8?B?VWhNUnE3b2dZcDhkaTdUYmhaMnB2RllJcVE0aFJMOS9tejNsR09VS0ovSGlt?=
 =?utf-8?B?Y2phaGhlZWllNmpaZTV1UW9CWmNHTm9BSG5pVDNOZUs0SHJWQTBkOHk4VGtR?=
 =?utf-8?B?TUVTbzl3aWlrQVVqUEhob3BtRG5YT0hkR1NNcXdIY2xmaEplaG1TK2N4ZVp2?=
 =?utf-8?B?UTNKb1ZlaTZ5andXb1BHajlqcGUxU2d0ajJyVU5SeGtvNjZWZ24yaC9WaDBC?=
 =?utf-8?B?UWFFdWlyQllNZDJNVDVsYmtYWEdqdm1vRm11YWFPOVVKbVJjQzUxay9CbGdx?=
 =?utf-8?B?Zkw1eW9LSFo3ODl2RmlxNGtsNmFJR2NiZEtPTFJOSFJObk9lWXhXWFRXekpy?=
 =?utf-8?B?Wk5xOW80Vm9Xb3V4UkdtQTNZbUJOU1pTZ3E1SnphYWErVmdySWNVblVsOEVO?=
 =?utf-8?B?ZWJhZVRkN29LWFFkYm5CQ1dIanlHUTZDTlV2S0NpZENnVXRxM3lwd3lYV2NT?=
 =?utf-8?B?emNTRFRNdXBtUlp2UFd5ZTlaM0FiSC9HTm5HM2x2WnJZTXNoTW5kbmNlT3ov?=
 =?utf-8?B?akdWdm5jNkpMRGkrTjlheVAyd2FuLzlkUWdnbmtNNkZhSXhhdVFzYXBNQUlH?=
 =?utf-8?B?UUtsM1hFaVFrZHI1akxzMDhoank4QkozeDBYZXpnbHJUY2xPVDM3YkRoTE93?=
 =?utf-8?B?a3l5VjlUTGt0SWF6L1NVWVZWYnpaOEVOWSsvTTk1ZGhmRXlHRCtFQ0cwc1R0?=
 =?utf-8?B?clVDdmdDeGhHQUVPSml5NjdMQklrZU1uSWZ0TzkzUG1pSTkwR1VMOXJsUDJs?=
 =?utf-8?B?eEMxMkJaS1EzKzExVXFhUjdnbFg5c0puUE5IQmVKbFQ4Y244alBxeVhXaEdK?=
 =?utf-8?B?YWhhYXlhdDR1OUhWblZvQzE3ZEJodnZsMWY4RmVFOUYxY3gwZkswdnZoSHlz?=
 =?utf-8?B?UWpJczZOZ1h1TU1KcTR5cFpweHQxKzlmNzBzZjhVK3ZaeW1FcEdJTjVROUtI?=
 =?utf-8?B?RDFTdEQ1NXBwQXVZU2pwMTV2OTNPZTZFVlVHbTBwYVZwVjZvb0xTSlVRRmNL?=
 =?utf-8?B?U3FNQkh6VVNwUGM0cTlBREx5ZUowTFM5ZGVHR0JXYmEvU0VxOGRKTDJRUjdl?=
 =?utf-8?B?dzQ4TytNK1dMaUJrQnRId3VHMFI2K2dvenB4TVl4ck43bGNZMTZxU2tkci96?=
 =?utf-8?B?TjlmUnlEdmlFam5qeGE2VHFZZU1GVjl4Ymg0K1A4bHFIN2pjR0MxU09rZVM4?=
 =?utf-8?B?SXhjcm9RNVBnZlBZR0xEbEw5S1V2UnRRay9ZZklpWTc0clN2MkxsOGNBQ1Yr?=
 =?utf-8?B?YmUvcjZxRzQ1ZGNLb2wrMlNoUERwbEpFNnlUV2JrbnEvTVc1ZjBMSVVlR3k1?=
 =?utf-8?B?UjJ3QVBDc29BNktJeDllREJwclJwY1l2QW81M1JBM2hpNFZiTUhWTGVxYnVm?=
 =?utf-8?B?U0hIbm44UUtTU1Z2c3p1bSs3dGtJOUljbi9PU3VjZUIxZElORFFUSnpEcVpQ?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f5ed46-e27c-4aa9-af93-08db8debd1c6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 15:20:18.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1C0SxPOwfUA4GfIaTay0FgFq1ELHeNMuy8LQIJMMRH8SkDzSvqGiNFcDdfCHaj6QqTL6oTPGVRRDZikJTHfyCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/26/23 10:15, Jakub Kicinski wrote:
> We repeatedly see netcomers misuse get_maintainer by running it on
Presumably you meant "newcomers"?  Or is this just a phrase for 
newcomers contributing to netdev? :)

> the file paths rather than the patchfile. This leads to authors
> of changes (quoted commits and commits under Fixes) not getting
> CCed. These are usually the best reviewers!
> 
> The file option should really not be used by inexperienced developers,
> unless they are just trying to find a maintainer to manually contact.
> 
> Print a warning when someone tries to use -f and remove
> the "auto-guessing" of file paths.
> 
> This script may break people's "scripts on top of get_maintainer"
> if they are using -f... but that's the point.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> note addressed:
>   - put more info into the warning. I think it's more than fine.
> v2:
>   - fix the subject (Greg)
>   - s/noob/inexperienced|newcomer/ (Joe)
>   - put the message on a single line (Joe)
>   - s/will/may/ (Joe)
>   - s/filepatch/patchfile/
>   - add more reasons to help
> v1: https://lore.kernel.org/all/20230725155926.2775416-1-kuba@kernel.org/
> 
> CC: joe@perches.com
> Cc: geert@linux-m68k.org
> Cc: gregkh@linuxfoundation.org
> Cc: netdev@vger.kernel.org
> Cc: workflows@vger.kernel.org
> Cc: mario.limonciello@amd.com
> ---
>   scripts/get_maintainer.pl | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index ab123b498fd9..4714056ca7f1 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -51,6 +51,7 @@ my $output_roles = 0;
>   my $output_rolestats = 1;
>   my $output_section_maxlen = 50;
>   my $scm = 0;
> +my $silence_file_warning = 0;
>   my $tree = 1;
>   my $web = 0;
>   my $subsystem = 0;
> @@ -267,6 +268,7 @@ if (!GetOptions(
>   		'subsystem!' => \$subsystem,
>   		'status!' => \$status,
>   		'scm!' => \$scm,
> +		'silence-file-warning!' => \$silence_file_warning,
>   		'tree!' => \$tree,
>   		'web!' => \$web,
>   		'letters=s' => \$letters,
> @@ -544,7 +546,11 @@ foreach my $file (@ARGV) {
>       if ($from_filename && (vcs_exists() && !vcs_file_exists($file))) {
>   	warn "$P: file '$file' not found in version control $!\n";
>       }
> -    if ($from_filename || ($file ne "&STDIN" && vcs_file_exists($file))) {
> +    if ($from_filename) {
> +	if (!$silence_file_warning) {
> +	    warn "$P: WARNING: Prefer running the script on patches as generated by git format-patch. Selecting paths is known to miss recipients!\n";
> +	}
> +
>   	$file =~ s/^\Q${cur_path}\E//;	#strip any absolute path
>   	$file =~ s/^\Q${lk_path}\E//;	#or the path to the lk tree
>   	push(@files, $file);
> @@ -1081,6 +1087,7 @@ version: $V
>     --mailmap => use .mailmap file (default: $email_use_mailmap)
>     --no-tree => run without a kernel tree
>     --self-test => show potential issues with MAINTAINERS file content
> +  --silence-file-warning => silence the warning about -f being used (see Notes)
>     --version => show version
>     --help => show this help information
>   
> @@ -1089,6 +1096,11 @@ version: $V
>      --pattern-depth=0 --remove-duplicates --rolestats]
>   
>   Notes:
> +  Using "-f file" is generally discouraged, running the script on a patchfile
> +      (as generated by git format-patch) is usually the right thing to do.
> +      It's easy to miss a file changed by a commit and the script
> +      may extract additional information from the commit message
> +      (keywords, Fixes tags etc.)
>     Using "-f directory" may give unexpected results:
>         Used with "--git", git signators for _all_ files in and below
>             directory are examined as git recurses directories.


